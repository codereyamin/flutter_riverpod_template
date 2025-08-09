import 'package:flutter/material.dart';
import 'package:flutter_riverpod_template/constant/app_colors.dart';
import 'package:flutter_riverpod_template/constant/app_constant.dart';

class AppText extends StatelessWidget {
  const AppText({
    super.key,
    required this.text,
    this.fontSize = 16,
    this.textScaleFactor = 0.9,
    this.color,
    this.fontWeight = FontWeight.w400,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.height,
    this.decoration,
    this.decorationColor,
  });
  final String text;
  final double? fontSize;
  final double textScaleFactor;
  final Color? color;
  final FontWeight? fontWeight;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final double? height;
  final TextDecoration? decoration;
  final Color? decorationColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines ?? 100,
      overflow: overflow ?? TextOverflow.ellipsis,
      textAlign: textAlign,
      style: Theme.of(context).textTheme.displaySmall?.copyWith(
        height: height,
        fontSize: fontSize,
        color: color ?? AppColors.instance.black500,
        fontWeight: fontWeight,
        fontFamily: AppConstant.instance.fontFamilyPoppins,
        decoration: decoration,
        decorationColor: decorationColor,
      ),
      textScaler: TextScaler.linear(textScaleFactor),
    );
  }
}
