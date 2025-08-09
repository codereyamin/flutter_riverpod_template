import 'package:flutter/material.dart';
import 'package:flutter_riverpod_template/constant/app_colors.dart';
import 'package:flutter_riverpod_template/constant/app_constant.dart';
import 'package:readmore/readmore.dart';

class AppExpandableText extends StatelessWidget {
  const AppExpandableText({
    super.key,
    required this.text,
    this.decoration,
    this.fontSize = 16,
    this.fontWeight,
    this.textAlign,
    this.textScaleFactor = 0.9,
    this.textColor,
    this.collopsText = "Show Less",
    this.expandedText = "Show More",
    this.collopsTextColor,
    this.decorationDecorationStyle,
    this.expandedTextColor,
    this.fontFamily,
    this.trimLines = 2,
  });
  final String text;
  final String? fontFamily;
  final String expandedText;
  final String collopsText;
  final Color? textColor;
  final Color? expandedTextColor;
  final Color? collopsTextColor;
  final double? fontSize;
  final double textScaleFactor;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextDecoration? decoration;
  final TextDecorationStyle? decorationDecorationStyle;
  final int trimLines;

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      text,
      trimMode: TrimMode.Line,
      trimLines: trimLines,
      colorClickableText: AppColors.instance.primary,
      trimCollapsedText: expandedText,
      trimExpandedText: collopsText,
      textAlign: textAlign,

      textScaler: TextScaler.linear(textScaleFactor),
      style: TextStyle(
        fontFamily: fontFamily ?? AppConstant.instance.fontFamilyPoppins,
        color: textColor,
        fontWeight: fontWeight,
        fontSize: fontSize,
        decoration: decoration,
        decorationStyle: decorationDecorationStyle,
      ),
      lessStyle: TextStyle(
        fontSize: 14,
        fontFamily: fontFamily ?? AppConstant.instance.fontFamilyPoppins,
        fontWeight: FontWeight.bold,
        color: collopsTextColor ?? AppColors.instance.primary,
      ),
      moreStyle: TextStyle(
        fontSize: 14,
        fontFamily: fontFamily ?? AppConstant.instance.fontFamilyPoppins,
        fontWeight: FontWeight.bold,
        color: expandedTextColor ?? AppColors.instance.primary,
      ),
    );
  }
}
