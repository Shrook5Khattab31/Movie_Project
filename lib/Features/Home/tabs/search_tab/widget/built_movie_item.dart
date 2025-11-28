import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_project/l10n/app_localizations_ar.dart';
import '../../../../../Model/MoviesModel/Movies.dart';
import '../../../../../core/theme/appColors.dart';
import '../../../../../core/theme/appStyles.dart';
import '../../../../../l10n/app_localizations.dart';

class BuiltMovieItem extends StatelessWidget {
  const BuiltMovieItem({super.key,required this.movie});
  final Movies movie;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(vertical: height*0.0001,horizontal: width*0.001),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grayLightColor.withAlpha(90)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: movie.mediumCoverImage ?? "",
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                CircularProgressIndicator(
                  color: AppColors.secondColor,
                ),
            errorWidget: (context, url, error) =>
                Icon(Icons.error, color: AppColors.redColor),
          ),
        ),
        title: Text(
          movie.title ?? "",
          style: AppStyles.reg18Yellow,
        ),
        subtitle: Text(
          movie.genres != null && movie.genres!.isNotEmpty
              ? movie.genres!.join(", ")
              : AppLocalizations.of(context)!.genres,
          style: AppStyles.reg16White,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: width*0.02,
          children: [
            Text(
              "${movie.rating}",
              style: AppStyles.reg16White,
            ),
            Icon(Icons.star, color: AppColors.secondColor),
          ],
        ),
      ),
    );
  }
}
