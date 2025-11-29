import 'package:flutter/material.dart';
import '../../../../../core/theme/appColors.dart';
import '../../../../../core/theme/appStyles.dart';
import '../../../../../l10n/app_localizations.dart';

class BuiltRecentSearches extends StatelessWidget {
  const BuiltRecentSearches({super.key, required this.itemList});
  final Widget itemList;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 0.04 * width,
        vertical: 0.02 * height,
      ),
      decoration: BoxDecoration(
        color: AppColors.grayDarkColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24, width: 0.004 * width),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: height * 0.02,
        children: [
          Text(AppLocalizations.of(context)!.recentSearches, style: AppStyles.semiBold16Yellow),
          itemList,
        ],
      ),
    );
  }
}
