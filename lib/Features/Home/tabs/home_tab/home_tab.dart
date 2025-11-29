import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_project/Features/Home/tabs/home_tab/cubit/home_tab_states.dart';
import 'package:movie_project/Features/Home/tabs/home_tab/cubit/home_tab_view_model.dart';
import 'package:movie_project/Model/MoviesModel/MovieResponse.dart';
import 'package:movie_project/core/constants/appAssets.dart';
import 'package:movie_project/core/routing/routeNames.dart';
import 'package:movie_project/core/theme/appColors.dart';
import 'package:movie_project/core/theme/appStyles.dart';
import 'package:movie_project/core/widgets/custom_movie_poster.dart';
import 'package:movie_project/core/widgets/custom_text_button.dart';
import 'package:movie_project/di/di.dart';
import '../../../../Model/MoviesModel/Movies.dart';
import '../../../moveDetails/movie_details_args.dart';
import '../../home_screen.dart';

class HomeTabScreen extends StatefulWidget {
  final String loginToken;

  const HomeTabScreen({
    super.key,
    required this.loginToken,
  });

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  int index = 0;
  final Map<String, List<Movies>> categorizedMovies = {};
 HomeTabViewModel viewModel =HomeTabViewModel(homeTabRepository: injectHomeTabRepository());
  @override
  void initState() {
    super.initState();
    viewModel.fetchMovies();
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => viewModel,
      child: BlocBuilder<HomeTabViewModel, HomeTabStates>(
        builder: (context, state) {
          if (state is HomeTabLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HomeErrorState) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          }

          if (state is HomeTabSuccessState) {
            final moviesList = state.movies;
            categorizedMovies.clear();
            for (final movie in moviesList) {
              for (final genre in movie.genres ?? []) {
                categorizedMovies.putIfAbsent(genre, () => []);
                categorizedMovies[genre]!.add(movie);
              }
            }
            return ListView(
              children: [
                Container(
                  height: height * 0.7,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColorWithObesity,
                  image: DecorationImage(
                    image: NetworkImage(moviesList[index].mediumCoverImage??"",),
                      fit: BoxFit.cover,
                  ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: AlignmentGeometry.topCenter,
                          end: AlignmentGeometry.bottomCenter,
                        colors: [
                            AppColors.primaryColorWithObesity,AppColors.primaryColor.withAlpha(233),AppColors.primaryColor
                          ]
                      )
                    ),
                    child: InkWell(
                    onTap:(){  Navigator.of(context).pushNamed(
                          AppRoutes.detailsScreen,
                        arguments: MovieDetailsArgs( movie: moviesList[index], token:widget.loginToken, movies:moviesList,)
                    );},
                      child: Container(
                        height: height * 0.6,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage(AppImages.availableMovies))
                        ),
                        child: CarouselSlider.builder(
                          itemCount: moviesList.length,
                        itemBuilder: (context, index, realIndex) => CustomMoviePoster(
                              imageWidth: width * 0.54,
                              imageHeight: height * 0.37,
                          image: moviesList[index].mediumCoverImage ?? '',
                          rating: moviesList[index].rating,
                        ),
                          options: CarouselOptions(
                            aspectRatio: 4 / 3,
                            autoPlay: true,
                          pauseAutoPlayOnManualNavigate: false,
                            enlargeCenterPage: true,
                            viewportFraction: 0.45,
                            enlargeFactor: 0.25,
                            enableInfiniteScroll: true,
                            autoPlayInterval: Duration(seconds: 7),
                            autoPlayAnimationDuration: Duration(seconds: 1),
                            onPageChanged: (newIndex, reason) {
                            setState(() {index = newIndex;});
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                ...categorizedMovies.entries.map((entry) {
                  final category = entry.key;
                  final filteredMovies = entry.value;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                        child: Row(
                          children: [
                            Text(category, style: AppStyles.reg20White),
                            const Spacer(),
                            CustomTextButton(
                              text: 'See More',
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) =>
                                      HomeScreen(
                                        args: widget.loginToken,
                                        initialBrowseGenre: category,
                                      ),
                                ),
                              );
                            },
                              styleText: AppStyles.reg16Yellow,
                            ),
                          Icon(Icons.arrow_forward, color: AppColors.secondColor, size: 12),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.25,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: filteredMovies.length,
                          itemBuilder: (context, i) {
                            final movie = filteredMovies[i];
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  AppRoutes.detailsScreen,
                                  arguments: MovieDetailsArgs( movies:moviesList, movie: movie, token:widget.loginToken));},
                              child: CustomMoviePoster(
                                imageWidth: width * 0.33,
                                imageHeight: height * 0.23,
                                image: movie.mediumCoverImage ?? '',
                                rating: movie.rating,
                              ),
                            );
                          },
                        separatorBuilder: (context, i) => SizedBox(width: width * 0.02),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                    ],
                  );
                }),
                SizedBox(height: height * 0.06),
              ],
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}