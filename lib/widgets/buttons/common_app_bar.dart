import 'package:flutter/material.dart';
import 'package:flutter_riverpod_template/constant/app_colors.dart';
import 'package:flutter_riverpod_template/utils/app_size.dart';
import 'package:flutter_riverpod_template/widgets/texts/app_text.dart';

AppBar commonAppBar({String? title, Widget? backButton, Widget? titleWidget, List<Widget>? actions}) {
  return AppBar(
    leading: backButton,
    centerTitle: true,
    title: titleWidget ?? AppText(text: title ?? "", fontSize: AppSize.width(value: 18)),
    backgroundColor: AppColors.instance.white50,
    surfaceTintColor: AppColors.instance.white50,
    elevation: 2,
    shadowColor: AppColors.instance.gray50.withValues(alpha: 0.2),
    actions: actions,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.only(
        bottomLeft: Radius.circular(AppSize.width(value: 5)),
        bottomRight: Radius.circular(AppSize.width(value: 5)),
      ),
    ),
  );
}
