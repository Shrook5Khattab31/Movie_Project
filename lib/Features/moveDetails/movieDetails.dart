import 'package:flutter/material.dart';
import 'package:movie_project/Model/MoviesModel/Movies.dart';
import 'package:movie_project/core/constants/appAssets.dart';
import 'package:movie_project/core/theme/appColors.dart';
import 'package:movie_project/core/theme/appStyles.dart';
import 'package:movie_project/core/widgets/custom_container.dart';
import 'package:movie_project/core/widgets/custom_elevated_btn.dart';
import 'package:movie_project/core/widgets/custom_movie_poster.dart';
import 'package:movie_project/l10n/app_localizations.dart';
import '../../Model/MovieDetailsModel/details.dart';
import '../../api/api_service.dart';
import '../../core/routing/routeNames.dart';
import '../../service/history_service.dart';
import 'movie_details_args.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({super.key});

  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  late Future<Movie> movieFuture;
  List<Movies> similarMovies = [];
  bool isFavorite = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var args = ModalRoute.of(context)!.settings.arguments as MovieDetailsArgs;

    movieFuture = ApiService.fetchMovie(args.movie.id);
    ApiService.getSimilarMovies(args.movie.id).then((movies) {
      setState(() {
        similarMovies = movies;
      });
    });

    ApiService.checkMovieIsFav(movieId: args.movie.id, token: args.token).then((isFav) {
      setState(() {
        isFavorite = isFav ?? false;
      });
    });
    HistoryService.addMovieToHistory(args.movie);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: FutureBuilder<Movie>(
        future: movieFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error loading movie"));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text("No movie data available"));
          }

          final movie = snapshot.data!;
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;
          final args = ModalRoute.of(context)!.settings.arguments as MovieDetailsArgs;

          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: height * 0.7,
                        alignment: Alignment.topCenter,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(movie.mediumCoverImage ?? ""),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        height: height * 0.7,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.primaryColorWithObesity80,
                              AppColors.primaryColorWithObesity60,
                              AppColors.primaryColor,
                            ],
                            begin: FractionalOffset.topCenter,
                            end: FractionalOffset.bottomCenter,
                            stops: [0.0, 0.47, 0.97],
                          ),
                        ),
                      ),
                      Container(
                        height: height * 0.7,
                        padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.02),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Icon(Icons.arrow_back_ios_outlined, color: AppColors.whiteColor),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    if (args.fromProfile) {
                                      try {
                                        await ApiService.removeFavorite(movieId: args.movie.id, token: args.token);
                                        Navigator.pop(context, args.movie);
                                      } catch (e) {
                                        rethrow;
                                      }
                                    } else {
                                      final lastFavorite = isFavorite;
                                      setState(() {
                                        isFavorite = !isFavorite;
                                      });
                                      try {
                                        final currentStatus = await ApiService.checkMovieIsFav(movieId: args.movie.id, token: args.token);
                                        if (!(currentStatus ?? false)) {
                                          await ApiService.addFavorite(movieId: args.movie.id, token: args.token, movie: args.movie);
                                        } else {
                                          await ApiService.removeFavorite(movieId: args.movie.id, token: args.token);
                                        }
                                        final updated = await ApiService.checkMovieIsFav(movieId: args.movie.id, token: args.token);
                                        setState(() {
                                          isFavorite = updated ?? lastFavorite;
                                        });
                                      } catch (e) {
                                        rethrow;
                                      }
                                    }
                                  },
                                  icon: Icon(
                                    isFavorite ? Icons.bookmark : Icons.bookmark_border,
                                    color: isFavorite ? AppColors.secondColor : AppColors.whiteColor,
                                  ),
                                ),
                              ],
                            ),
                            Expanded(child: Image.asset(AppImages.play)),
                            Text(movie.title ?? "", style: AppStyles.bold24White, textAlign: TextAlign.center),
                            SizedBox(height: height * 0.016),
                            Text("${movie.year}", style: AppStyles.bold20Gray, textAlign: TextAlign.center),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.01),
                    child: Column(
                      spacing: height * 0.02,
                      children: [
                        CustomElevatedButton(
                          onPressed: () {},
                          backgroundColor: AppColors.redColor,
                          text: AppLocalizations.of(context)!.watch,
                          textStyle: AppStyles.bold20White,
                          height: 70,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomContainer(icon: AppImages.likeIcon, text: "15"),
                            CustomContainer(icon: AppImages.timeIcon, text: "${movie.runtime}"),
                            CustomContainer(icon: AppImages.starIcon, text: "${movie.rating}"),
                          ],
                        ),
                      ],
                    ),
                  ),

                  buildTitle(title: AppLocalizations.of(context)!.screen_shots),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.037, vertical: height * 0.005),
                    child: Column(
                      children: [
                        if (movie.largeScreenshotImage1 != null) buildScreenshot(movie.largeScreenshotImage1!),
                        SizedBox(height: height * 0.02),
                        if (movie.largeScreenshotImage2 != null) buildScreenshot(movie.largeScreenshotImage2!),
                        SizedBox(height: height * 0.02),
                        if (movie.largeScreenshotImage3 != null) buildScreenshot(movie.largeScreenshotImage3!),
                      ],
                    ),
                  ),

                  buildTitle(title: AppLocalizations.of(context)!.similar),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.037, vertical: height * 0.005),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: height * 0.016,
                          crossAxisSpacing: width * 0.02,
                          childAspectRatio: 3 / 4),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => Navigator.pushNamed(
                            context,
                            AppRoutes.detailsScreen,
                            arguments: MovieDetailsArgs(movies: args.movies, movie: similarMovies[index], token: args.token),
                          ),
                          child: CustomMoviePoster(
                            imageWidth: width * 0.5,
                            imageHeight: height * 0.3,
                            image: similarMovies[index].mediumCoverImage ?? "",
                            rating: similarMovies[index].rating,
                          ),
                        );
                      },
                      itemCount: similarMovies.length,
                    ),
                  ),

                  buildTitle(title: AppLocalizations.of(context)!.summary),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.037, vertical: height * 0.005),
                    child: Text(
                      movie.descriptionFull ?? "No Summary Available",
                      style: AppStyles.reg16White,
                    ),
                  ),

                  buildTitle(title: AppLocalizations.of(context)!.cast),
                  movie.cast == null || movie.cast!.isEmpty
                      ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text("No cast available", style: TextStyle(color: Colors.white70, fontSize: 16)))
                      : Column(
                    children: movie.cast!.map((actor) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.037, vertical: height * 0.005),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: height * 0.02, vertical: width * 0.02),
                          decoration: BoxDecoration(
                            color: AppColors.grayDarkColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: (actor.urlSmallImage != null && actor.urlSmallImage!.isNotEmpty)
                                    ? Image.network(actor.urlSmallImage!, width: 70, height: 70, fit: BoxFit.cover)
                                    : Image.asset(AppImages.noImage, width: 70, height: 70, fit: BoxFit.cover),
                              ),
                              SizedBox(width: width * 0.02),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Name : ${actor.name}", style: AppStyles.reg20White),
                                    SizedBox(height: height * 0.003),
                                    Text("Character : ${actor.characterName}", style: AppStyles.reg20White),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  buildTitle(title: AppLocalizations.of(context)!.genres),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.037, vertical: height * 0.005),
                    child: Wrap(
                      spacing: width * 0.04,
                      runSpacing: height * 0.015,
                      children: (movie.genres ?? []).map((genre) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: height * 0.04, vertical: width * 0.02),
                          decoration: BoxDecoration(
                            color: AppColors.grayDarkColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(genre.toString(), style: AppStyles.reg16White),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildScreenshot(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.network(url, fit: BoxFit.cover),
    );
  }

  Padding buildTitle({required String title}) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.005),
      child: Text(title, style: AppStyles.bold24White),
    );
  }
}