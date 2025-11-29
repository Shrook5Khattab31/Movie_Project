import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_project/Features/Home/tabs/search_tab/search_cubit.dart';
import 'package:movie_project/Features/Home/tabs/search_tab/widget/built_movie_item.dart';
import 'package:movie_project/core/constants/appAssets.dart';
import 'package:movie_project/core/routing/routeNames.dart';
import 'package:movie_project/core/theme/appColors.dart';
import 'package:movie_project/core/theme/appStyles.dart';
import 'package:movie_project/l10n/app_localizations.dart';
import '../../../moveDetails/movie_details_args.dart';
import 'widget/built_recent_searches.dart';
import 'widget/built_search_item.dart';
import 'widget/built_search_text__form_field.dart';

class SearchTabScreen extends StatefulWidget {
  final String loginToken;
  const SearchTabScreen({super.key, required this.loginToken});

  @override
  State<SearchTabScreen> createState() => _SearchTabScreenState();
}

class _SearchTabScreenState extends State<SearchTabScreen> {
  SearchCubit viewModel = SearchCubit();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocBuilder<SearchCubit, SearchState>(
      bloc: viewModel,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.primaryColor,
          appBar: BuiltSearchTextFormField(
            searchController: viewModel.searchController,
            onPressedClear: () {
              viewModel.clearSearch();
            },
            onTap: () {
              viewModel.setFocus(!viewModel.isTextFieldFocused);
            },
            onChanged: (value) {
              viewModel.getMovieBySearch(value);
            },
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 0.04 * width,
              vertical: 0.01 * height,
            ),
            child: buildBody(state, height),
          ),
        );
      },
    );
  }

  Widget buildBody(SearchState state, double height) {
     //todo show recent searches
    if(state is SearchFocus){
      return BuiltRecentSearches(
        itemList: ListView.separated(
          shrinkWrap: true,
          itemCount: viewModel.recentSearches.length,
          separatorBuilder: (context, index) =>
              SizedBox(height: height * 0.03),
          itemBuilder: (context, index) {
            final item = viewModel.recentSearches[index];
            return InkWell(
              onTap: () {
                viewModel.searchController.text = item;
                viewModel.setFocus(false);
                viewModel.getMovieBySearch(item);
              },
              child: BuiltSearchItem(item: item),
            );
          },
        ),
      );

    }
    //todo loading to search
    if (state is SearchLoading) {
      return Center(
        child: CircularProgressIndicator(color: AppColors.secondColor),
      );
    }

    //todo found movie
    if (state is SearchSuccess) {
      return ListView.separated(
        itemCount: state.movieList.length,
        separatorBuilder: (_, __) => SizedBox(height: height * 0.02),
        itemBuilder: (context, index) {
          final movie = state.movieList[index];
          return InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.detailsScreen,
                arguments: MovieDetailsArgs(
                  movies: state.movieList,
                  movie: movie,
                  token: widget.loginToken,
                ),
              );
            },
            child: BuiltMovieItem(movie: movie),
          );
        },
      );
    }

    //todo not found movie
    if (state is SearchEmpty) {
      return Center(
        child: Text(
          AppLocalizations.of(context)!.no_movies_found,
          style: AppStyles.reg18White,
        ),
      );
    }

    // todo error
    if (state is SearchError) {
      return Center(
        child: Text(state.errorMessage, style: AppStyles.reg18White),
      );
    }
    //todo start and empty TextField(controller) SearchInitial
      return Center(child: Image.asset(AppImages.emptyList));

  }
}
