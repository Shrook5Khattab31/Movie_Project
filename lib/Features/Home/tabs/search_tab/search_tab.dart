import 'package:flutter/material.dart';
import 'package:movie_project/api/api_service.dart';
import 'package:movie_project/core/constants/appAssets.dart';
import 'package:movie_project/core/routing/routeNames.dart';
import 'package:movie_project/core/theme/appColors.dart';
import 'package:movie_project/core/theme/appStyles.dart';
import 'package:movie_project/core/widgets/custom_text_form_field.dart';
import 'package:movie_project/l10n/app_localizations.dart';
import '../../../../Model/MoviesModel/Movies.dart';
import 'widget/built_movie_item.dart';

class SearchTabScreen extends StatefulWidget {
  const SearchTabScreen({super.key});

  @override
  State<SearchTabScreen> createState() => _SearchTabScreenState();
}

class _SearchTabScreenState extends State<SearchTabScreen> {
  TextEditingController searchController = TextEditingController();

  bool isLoading = false;
  List<Movies> searchResults = [];

  Future<void> getMovieBySearch(String text) async {
    if (text.isEmpty) return;
    setState(() => isLoading = true);
    try {
      final result = await ApiService.searchMovies(text);
      setState(() {
        searchResults = result;
      });
    } catch (e) {
      setState(() {
        searchResults = [];
      });
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        toolbarHeight: 0.1 * height,
        backgroundColor: AppColors.primaryColor,
        title: CustomTextFormField(
          controller: searchController,
          hintText: "Search",
          hintStyle: AppStyles.reg16White,
          fillColor: AppColors.grayDarkColor,
          prefixIcon: Image.asset(AppImages.searchIcon),
          suffixIcon: IconButton(
            onPressed: () {
              searchController.clear();
              searchResults.clear();
              setState(() {});
            },
            icon: const Icon(Icons.clear),
          ),
          onChanged: (value) {
            if (value.isNotEmpty) {
              getMovieBySearch(value);
            } else {
              searchResults.clear();
              setState(() {});
            }
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 0.04 * width,
          vertical: 0.02 * height,
        ),
        child: //todo found movie
        searchResults.isNotEmpty
            ? ListView.separated(
                itemCount: searchResults.length,
                separatorBuilder: (context, index) =>
                    SizedBox(height: height * 0.02),
                itemBuilder: (context, index) {
                  final movie = searchResults[index];
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.detailsScreen,
                        arguments: movie,
                      );
                    },
                    child: BuiltMovieItem(movie: movie),
                  );
                },
              )
            : Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //todo start and empty TextField(controller)
                    if (searchController.text.isEmpty)
                      Image.asset(AppImages.emptyList),
                    //todo loading to search
                    if (isLoading)
                      CircularProgressIndicator(color: AppColors.secondColor),
                    //todo not found movie
                    if (!isLoading &&
                        searchController.text.isNotEmpty &&
                        searchResults.isEmpty)
                      Text(
                        AppLocalizations.of(context)!.no_movies_found,
                        style: AppStyles.reg18White,
                      ),
                  ],
                ),
              ),
      ),
    );
  }
}
