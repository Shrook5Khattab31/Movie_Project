import 'package:flutter/material.dart';
import '../../../../../core/constants/appAssets.dart';
import '../../../../../core/theme/appColors.dart';
import '../../../../../core/theme/appStyles.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../l10n/app_localizations.dart';

class BuiltSearchTextFormField extends StatelessWidget implements PreferredSizeWidget {
  const BuiltSearchTextFormField({
    super.key,
    required this.searchController,
    required this.onPressedClear,
    required this.onTap,
    required this.onChanged,
  });
  final TextEditingController searchController;
  final void Function() onPressedClear;
  final void Function()? onTap;
  final dynamic Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return AppBar(
      scrolledUnderElevation: 0,
      toolbarHeight: height,
      backgroundColor: AppColors.primaryColor,
      title: CustomTextFormField(
        controller: searchController,
        hintText: AppLocalizations.of(context)!.search,
        hintStyle: AppStyles.reg16White,
        fillColor: AppColors.grayDarkColor,
        prefixIcon: Image.asset(AppImages.searchIcon),
        suffixIcon: IconButton(
          onPressed: onPressedClear,
          icon: const Icon(Icons.clear),
        ),
        onTap: onTap,
        onChanged: onChanged,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>  Size.fromHeight(80);

}
