import 'package:flutter/material.dart';
import 'package:movie_project/Features/Home/tabs/search_tab/widget/built_recent_searches.dart';
import 'package:movie_project/Features/Home/tabs/search_tab/widget/built_search_item.dart';
import 'package:movie_project/Features/Home/tabs/search_tab/widget/built_search_text__form_field.dart';
import 'package:movie_project/api/api_service.dart';
import 'package:movie_project/core/constants/appAssets.dart';
import 'package:movie_project/core/routing/routeNames.dart';
import 'package:movie_project/core/theme/appColors.dart';
import 'package:movie_project/core/theme/appStyles.dart';
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
  List<String> recentSearches = [];

  Future<void> getMovieBySearch(String text) async {
    if (text.isEmpty) return;
    if (!recentSearches.contains(text)) {
      //todo already found movie --> change place
      recentSearches.insert(0, text);
      if (recentSearches.length > 5) {
        recentSearches.removeLast();
      }
    }
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

  bool isTextFieldFocused = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: BuiltSearchTextFormField(
        searchController: searchController,
        onPressedClear: () {
          searchController.clear();
          searchResults.clear();
          setState(() {});
        },
        onTap: () {
          setState(() {
            isTextFieldFocused = true;
          });
        },
        onChanged: (value) {
          isTextFieldFocused = false;
          if (value.isNotEmpty) {
            getMovieBySearch(value);
          } else {
            searchResults.clear();
            setState(() {});
          }
        },
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 0.04 * width,
          vertical: 0.01 * height,
        ),
        //todo found movie
        child: searchResults.isNotEmpty
            ? ListView.separated(
                itemCount: searchResults.length,
                separatorBuilder: (_, __) => SizedBox(height: height * 0.02),
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
            : isTextFieldFocused && recentSearches.isNotEmpty
            ?
              //todo show recent searches
              BuiltRecentSearches(
                itemList: ListView.separated(
                  shrinkWrap: true,
                  itemCount: recentSearches.length,
                  separatorBuilder: (context, index) =>
                      SizedBox(height: height * 0.03),
                  itemBuilder: (context, index) {
                    final item = recentSearches[index];
                    return InkWell(
                      onTap: () {
                        searchController.text = item;
                        isTextFieldFocused = false;
                        getMovieBySearch(item);
                        setState(() {});
                      },
                      child: BuiltSearchItem(item: item),
                    );
                  },
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //todo start and empty TextField(controller)
                  if (!isTextFieldFocused &&
                      searchController.text.isEmpty &&
                      recentSearches.isEmpty)
                    Center(child: Image.asset(AppImages.emptyList)),

                  //todo loading to search
                  if (isLoading)
                    Center(
                      child: CircularProgressIndicator(
                        color: AppColors.secondColor,
                      ),
                    ),

                  //todo not found movie
                  if (!isLoading &&
                      searchController.text.isNotEmpty &&
                      searchResults.isEmpty)
                    Center(
                      child: Text(
                        AppLocalizations.of(context)!.no_movies_found,
                        style: AppStyles.reg18White,
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
