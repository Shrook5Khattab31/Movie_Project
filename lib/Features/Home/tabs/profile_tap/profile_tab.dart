import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_project/Model/favorites/favorite.dart';
import 'package:movie_project/core/constants/appAssets.dart';
import 'package:movie_project/core/routing/routeNames.dart';
import 'package:movie_project/core/theme/appColors.dart';
import 'package:movie_project/core/utils/custom_profile_builder.dart';

import '../../../../Model/MoviesModel/Movies.dart';
import '../../../../api/api_service.dart';
import '../../../../core/widgets/custom_movie_poster.dart';
import '../../../moveDetails/movie_details_args.dart';

class ProfileTabScreen extends StatefulWidget {
  final String loginToken;

  const ProfileTabScreen({super.key, required this.loginToken,});

  @override
  State<ProfileTabScreen> createState() => _ProfileTabScreenState();
}

class _ProfileTabScreenState extends State<ProfileTabScreen> {
  Future<Map<String, dynamic>>? profileFuture;
  late bool isGoogleLogin;
  int currentAvatarId = 1;
  List<Favorite> favoriteMovies = [];
  String selectedAvatar = AppImages.avatar1;
  final List<String> avatars = [
    AppImages.avatar1, AppImages.avatar2, AppImages.avatar3,
    AppImages.avatar4, AppImages.avatar5, AppImages.avatar6,
    AppImages.avatar7, AppImages.avatar8, AppImages.avatar9
  ];

  @override
  void initState() {
    super.initState();
    isGoogleLogin = widget.loginToken.isEmpty;
    if (!isGoogleLogin) {
      profileFuture = ApiService().getProfile(widget.loginToken);
      ApiService.getAllFavoritesMovies(token: widget.loginToken).then((
          favorite) {
        setState(() => favoriteMovies = favorite);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: isGoogleLogin
            ? buildGoogleProfile(width, height) :
        FutureBuilder<Map<String, dynamic>>(
          future: profileFuture,
          builder: (context,snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error loading profile"));
            }
            final data = snapshot.data!;
            final userName = data['name'] ?? 'User';

            currentAvatarId = snapshot.data!['avaterId'] ?? currentAvatarId;
            int index = (currentAvatarId >= 1 &&
                currentAvatarId <= avatars.length)
                ? currentAvatarId - 1 : 0;
            var avatarPath = avatars[index];
            return SafeArea(
              child: Column(
                children: [
                  Container(
                    color: AppColors.lightBlackColor,
                    child: Column(
                      children: [
                        CustomProfileBuilder.buildProfileHeader(
                            avatarPath: avatarPath,
                            userName: userName,
                            width: width,
                            height: height,
                            context: context,
                            favoriteMovies: favoriteMovies),
                        CustomProfileBuilder.buildActionButtons(width: width,
                          onPressed: () async {
                            final result = await Navigator
                                .of(context)
                                .pushNamed(
                              AppRoutes.updateProfileScreen,
                              arguments: widget.loginToken,
                            );
                            if (result != null && result is int) {
                              setState(() {
                                avatarPath = avatars[result - 1];
                                profileFuture =
                                    ApiService().getProfile(widget.loginToken);
                              });
                            }
                          },
                          context: context,
                        ),
                        SizedBox(height: height * 0.03),
                        CustomProfileBuilder.buildProfileTabs(context: context),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        SingleChildScrollView(
                            child: favoriteMovies.isNotEmpty ?
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.037,
                                    vertical: height * 0.005),
                                child:
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: height * 0.016,
                                      crossAxisSpacing: width * 0.02,
                                      childAspectRatio: 3 / 4),
                                  itemCount: favoriteMovies.length,
                                  itemBuilder: (context, index) {
                                    List<
                                        Movies> favoriteMoviesAsMovies = favoriteMovies
                                        .map((fav) =>
                                        Movies(
                                          id: int.tryParse(fav.movieId ?? "0"),
                                          title: fav.name,
                                          rating: fav.rating,
                                          year: int.tryParse(fav.year ?? "0"),
                                          smallCoverImage: fav.imageURL,
                                          mediumCoverImage: fav.imageURL,
                                          largeCoverImage: fav.imageURL,
                                        )).toList();
                                    final movie = favoriteMoviesAsMovies[index];
                                    return GestureDetector(
                                      onTap: () async {
                                        final removedMovie = await Navigator
                                            .pushNamed(
                                          context,
                                          AppRoutes.detailsScreen,
                                          arguments: MovieDetailsArgs(
                                            movies: favoriteMoviesAsMovies,
                                            movie: movie,
                                            token: widget.loginToken,
                                            fromProfile: true,
                                          ),
                                        );

                                        if (removedMovie != null &&
                                            removedMovie is Movies) {
                                          setState(() {
                                            favoriteMovies.removeWhere((m) {
                                              return m.movieId ==
                                                  removedMovie.id.toString();
                                            });
                                          });
                                        }
                                      },
                                      child: CustomMoviePoster(
                                        imageWidth: width * 0.5,
                                        imageHeight: height * 0.3,
                                        image: favoriteMovies[index].imageURL ??
                                            "",
                                        rating: favoriteMovies[index].rating ??
                                            0.0,
                                      ),);
                                  },
                                )
                            ) : Image.asset(AppImages.emptyList)),
                        Center(child: Image.asset(AppImages.emptyList)),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }

  Widget buildGoogleProfile(double width, double height) {
    return Column(
      children: [
        Container(
          color: AppColors.lightBlackColor,
          child: Column(
            children: [
              CustomProfileBuilder.buildProfileHeader(
                context: context,
                avatarPath: selectedAvatar,
                userName: FirebaseAuth.instance.currentUser?.displayName ??
                    "Google User",
                width: width,
                height: height,
                favoriteMovies: favoriteMovies,
              ),
              CustomProfileBuilder.buildActionButtons(
                width: width,
                onPressed: () {
                  //todo: firebase implementation
                },
                context: context,
              ),
              SizedBox(height: height * 0.03),
              CustomProfileBuilder.buildProfileTabs(context: context),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            children: [
              Center(child: Image.asset(AppImages.emptyList)),
              Center(child: Image.asset(AppImages.emptyList)),
            ],
          ),
        ),
      ],
    );
  }
}