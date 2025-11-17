import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_project/Model/MovieResponse.dart';
import 'package:movie_project/api/api_service.dart';
import 'package:movie_project/core/constants/appAssets.dart';
import 'package:movie_project/core/routing/routeNames.dart';
import 'package:movie_project/core/theme/appColors.dart';
import 'package:movie_project/core/theme/appStyles.dart';
import 'package:movie_project/core/widgets/custom_movie_poster.dart';
import 'package:movie_project/core/widgets/custom_text_button.dart';
import '../../../../Model/Movies.dart';
import '../../../../core/utils/custom_dialog.dart';

class HomeTabScreen extends StatefulWidget{
  const HomeTabScreen({super.key});

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  int index=0;
  int genreIndex=0;
  late Future<MovieResponse> moviesFuture;
  final Map<String, List<Movies>> categorizedMovies = {};
  var moviesList=[];
  @override
  void initState() {
    super.initState();
    moviesFuture = ApiService.getAllMovies(page: 1);
  }
  @override
  Widget build(BuildContext context) {
    var height= MediaQuery.of(context).size.height;
    var width= MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: FutureBuilder<MovieResponse>(
      future: moviesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.data?.status != 'ok') {
          return Center(child: Text(snapshot.data!.statusMessage!));
        }

        moviesList = snapshot.data!.data?.movies ?? [];

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
                height: height*0.7,
                decoration: BoxDecoration(
                  color: AppColors.primaryColorWithObesity,
                  image: DecorationImage(
                    image: NetworkImage(moviesList[index].mediumCoverImage,),
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
                    onTap:(){ Navigator.of(context).pushNamed(AppRoutes.detailsScreen,
                        arguments: moviesList[index] );},
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
                          aspectRatio: 4/3,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          viewportFraction: 0.45,
                          enlargeFactor: 0.25,
                          enableInfiniteScroll: true,
                          autoPlayInterval: Duration(seconds: 10),
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
                              // TODO: navigate to a category page
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
                            onTap: (){
                              Navigator.of(context).pushNamed(AppRoutes.detailsScreen,
                                  arguments: movie);}
                            ,
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
                  ],
                );
              }),
              SizedBox(height: height * 0.06),
            ],
          );
        },
      ),
    );
  }
}