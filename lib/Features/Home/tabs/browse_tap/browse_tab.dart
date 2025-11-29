import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_project/Features/Home/tabs/home_tab/cubit/home_tab_states.dart';
import 'package:movie_project/Features/Home/tabs/home_tab/cubit/home_tab_view_model.dart';
import 'package:movie_project/Model/MoviesModel/Movies.dart';
import 'package:movie_project/core/theme/appColors.dart';
import 'package:movie_project/core/theme/appStyles.dart';
import 'package:movie_project/core/widgets/custom_movie_poster.dart';
import 'package:movie_project/core/routing/routeNames.dart';
import 'package:movie_project/di/di.dart';
import '../../../moveDetails/movie_details_args.dart';

class BrowseTabScreen extends StatefulWidget {
  final String loginToken;
  const BrowseTabScreen({super.key, required this.loginToken});

  @override
  State<BrowseTabScreen> createState() => _BrowseTabScreenState();
}

class _BrowseTabScreenState extends State<BrowseTabScreen> {
  HomeTabViewModel viewModel = HomeTabViewModel(homeTabRepository: injectHomeTabRepository());
  String? selectedGenre;

  List<Movies> get filteredMovies {
    if (selectedGenre == null || viewModel.state is! HomeTabSuccessState) return [];
    final moviesList = (viewModel.state as HomeTabSuccessState).movies;
    return moviesList.where((m) => m.genres?.contains(selectedGenre) ?? false).toList();
  }

  @override
  void initState() {
    super.initState();
    viewModel.fetchMovies(); // استدعاء fetchMovies وسيتم emit للstate
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (_) => viewModel,
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

            // استخراج كل الجانرات
            Set<String> genresSet = {};
            for (var movie in moviesList) {
              if (movie.genres != null) genresSet.addAll(movie.genres!);
            }
            final genresList = genresSet.toList()..sort();

            selectedGenre ??= genresList.isNotEmpty ? genresList.first : null;

            return Column(
              children: [
                SizedBox(
                  height: height * 0.055,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                    itemCount: genresList.length,
                    separatorBuilder: (_, __) => SizedBox(width: width * 0.02),
                    itemBuilder: (context, index) {
                      final genre = genresList[index];
                      final isSelected = genre == selectedGenre;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedGenre = genre;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: width * 0.04, vertical: height * 0.01),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.secondColor
                                : AppColors.transparentColor,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                color: AppColors.secondColor, width: width * 0.005),
                          ),
                          child: Center(
                            child: Text(
                              genre,
                              style: isSelected
                                  ? AppStyles.bold20Black
                                  : AppStyles.bold20Yellow,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: height * 0.02),
                Expanded(
                  child: GridView.builder(
                    padding:
                    EdgeInsets.symmetric(horizontal: width * 0.02, vertical: height * 0.02),
                    physics: const BouncingScrollPhysics(),
                    itemCount: filteredMovies.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 4,
                      mainAxisSpacing: height * 0.016,
                      crossAxisSpacing: width * 0.02,
                    ),
                    itemBuilder: (context, index) {
                      final movie = filteredMovies[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            AppRoutes.detailsScreen,
                            arguments: MovieDetailsArgs(
                              movies: moviesList,
                              movie: movie,
                              token: widget.loginToken,
                            ),
                          );
                        },
                        child: CustomMoviePoster(
                          imageWidth: width * 0.5,
                          imageHeight: height * 0.3,
                          image: movie.mediumCoverImage ?? '',
                          rating: movie.rating,
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }

          return const SizedBox(); // fallback
        },
      ),
    );
  }
}
