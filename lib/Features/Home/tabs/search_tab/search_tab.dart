import 'package:flutter/material.dart';
import 'package:movie_project/core/constants/appAssets.dart';
import 'package:movie_project/core/widgets/custom_text_form_field.dart';

import '../../../../l10n/app_localizations.dart';

class SearchTabScreen extends StatelessWidget{
  const SearchTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    TextEditingController searchController = TextEditingController();
    return  Container(
      height: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: width*0.02, vertical: height*0.01),
      decoration: BoxDecoration(image: DecorationImage(image: AssetImage(AppImages.emptyList))),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width*0.02, vertical: height*0.02),
        child: CustomTextFormField(
          prefixIcon: Icon(Icons.search),
            controller: searchController,
            hintText: AppLocalizations.of(context)!.search),
      ),
    );
  }
}
