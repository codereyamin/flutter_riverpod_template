import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod_template/constant/app_colors.dart';
import 'package:flutter_riverpod_template/constant/app_constant.dart';
import 'package:flutter_riverpod_template/utils/app_log.dart';
import 'package:flutter_riverpod_template/utils/app_size.dart';
import 'package:flutter_riverpod_template/utils/gap.dart';
import 'package:flutter_riverpod_template/widgets/texts/app_text.dart';

class AppInputWidgetTwo extends StatefulWidget {
  const AppInputWidgetTwo({
    super.key,
    this.title,
    this.subTitle,
    this.hintText = "",
    this.labelText = "",
    this.prefix,
    this.suffixIcon,
    this.isPassWord = false,
    this.isEmail = false,
    this.textInputAction = TextInputAction.next,
    this.controller,
    this.keyboardType,
    this.fillColor,
    this.elevation = 0.0,
    this.elevationColor,
    this.minLines = 1,
    this.maxLines,
    this.readOnly = false,
    this.isOptional = false,
    this.border,
    this.errBorder,
    this.titleColor,
    this.onTap,
    this.style,
    this.hintStyle,
    this.padding,
    this.contentPadding,
    this.isPassWordSecondValidation = false,
    this.isPassWordSecondValidationController,
    this.textAlign = TextAlign.start,
    this.suffixIconConstraints,
    this.inputFormatters,
    this.onChanged,
    this.onFieldSubmitted,
    this.borderColor,
    this.textCapitalization = TextCapitalization.none,
    this.validator,
    this.labelStyle,
    this.alignLabelWithHint,
    this.errorColor,
    this.textColor,
    this.titleFontSize,
    this.fontWeight,
  });
  final String? title;
  final String? subTitle;
  final String hintText;
  final String labelText;
  final Widget? prefix;
  final Widget? suffixIcon;
  final bool isPassWord;
  final bool readOnly;
  final bool isEmail;
  final bool isOptional;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Color? fillColor;
  final Color? borderColor;
  final Color? titleColor;
  final double elevation;
  final Color? elevationColor;
  final Color? errorColor;
  final Color? textColor;
  final int minLines;
  final int? maxLines;
  final InputBorder? border;
  final InputBorder? errBorder;
  final void Function()? onTap;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? contentPadding;
  final bool isPassWordSecondValidation;
  final TextEditingController? isPassWordSecondValidationController;
  final TextAlign textAlign;
  final BoxConstraints? suffixIconConstraints;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final TextCapitalization textCapitalization;
  final String? Function(String?)? validator;
  final bool? alignLabelWithHint;
  final double? titleFontSize;
  final FontWeight? fontWeight;
  @override
  State<AppInputWidgetTwo> createState() => _AppInputWidgetTwoState();
}

class _AppInputWidgetTwoState extends State<AppInputWidgetTwo> {
  bool isShowPassWord = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? EdgeInsets.symmetric(horizontal: AppSize.width(value: 20.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null) const Gap(height: 15),
          if (widget.title != null)
            SizedBox(
              width: AppSize.size.width,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AppText(
                      text: widget.title ?? "",
                      fontWeight: FontWeight.w500,
                      color: widget.titleColor ?? AppColors.instance.black900,
                      fontSize: widget.titleFontSize ?? 18,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: AppSize.width(value: 10.0)),
                      child: AppText(
                        text: widget.subTitle ?? "",
                        fontWeight: widget.fontWeight ?? FontWeight.w400,
                        color: widget.titleColor ?? AppColors.instance.black900,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (widget.title != null) const Gap(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSize.width(value: 8.0)),
            child: TextFormField(
              textCapitalization: widget.textCapitalization,
              onTap: widget.onTap,
              readOnly: widget.readOnly,
              controller: widget.controller,
              minLines: widget.minLines,
              maxLines: widget.maxLines,
              onChanged: widget.onChanged,
              onFieldSubmitted: widget.onFieldSubmitted,
              validator:
                  widget.validator ??
                  (value) {
                    if (value != null && value.isNotEmpty) {
                      try {
                        if (widget.controller != null) {
                          widget.controller!.text = value;
                        }
                      } catch (e) {
                        errorLog("validator", e);
                      }
                    }
                    if (widget.isOptional) {
                      return null;
                    }
                    if (value == null || value.isEmpty) {
                      return "This field is required";
                    }

                    if (widget.isPassWord && value.length < 8) {
                      return "Must be at last 8 characters.";
                    }
                    if (widget.isEmail) {
                      if (isValidEmail(value.toString())) return null;
                      return "Please provide a valid email address";
                    }
                    if (widget.isPassWord && widget.isPassWordSecondValidation) {
                      if (widget.isPassWordSecondValidationController != null) {
                        if (value.toLowerCase() != widget.isPassWordSecondValidationController!.text.toLowerCase()) {
                          return "Both passwords most match";
                        } else {
                          return null;
                        }
                      }
                    }

                    return null;
                  },
              inputFormatters: widget.inputFormatters,
              keyboardType: widget.keyboardType,
              textInputAction: widget.textInputAction,
              obscureText: widget.isPassWord && isShowPassWord,
              obscuringCharacter: "*",
              textAlignVertical: TextAlignVertical.top,
              style:
                  widget.style ??
                  Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(color: widget.textColor ?? AppColors.instance.black300, fontWeight: FontWeight.w400, fontSize: 16),
              textAlign: widget.textAlign,
              decoration: InputDecoration(
                alignLabelWithHint: widget.alignLabelWithHint,

                hoverColor: AppColors.instance.transparent,
                filled: true,
                contentPadding: widget.contentPadding ?? EdgeInsets.all(AppSize.width(value: 15.0)),
                fillColor: widget.fillColor ?? AppColors.instance.primary,
                prefixIcon: widget.prefix,
                suffixIcon: widget.isPassWord
                    ? Container(
                        margin: const EdgeInsets.all(5),
                        width: 10,
                        height: 10,
                        child: IconButton(
                          color: AppColors.instance.primary,
                          padding: EdgeInsets.zero,
                          highlightColor: AppColors.instance.white500,
                          onPressed: () {
                            setState(() {
                              isShowPassWord = !isShowPassWord;
                            });
                          },
                          icon: isShowPassWord ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                        ),
                      )
                    : widget.suffixIcon,
                suffixIconConstraints: widget.suffixIconConstraints,
                hintText: widget.hintText,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: widget.labelText,
                hintStyle: widget.hintStyle ?? Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.instance.black300),
                labelStyle: widget.hintStyle ?? Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.instance.black300),
                errorStyle: TextStyle(
                  color: widget.errorColor ?? AppColors.instance.error,
                  fontWeight: FontWeight.w500,
                  fontFamily: AppConstant.instance.fontFamilyPoppins,
                  fontSize: 12,
                ),
                border:
                    widget.border ??
                    OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSize.width(value: 8.0)),
                      borderSide: BorderSide(color: widget.borderColor ?? AppColors.instance.primary),
                    ),
                enabledBorder:
                    widget.border ??
                    OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSize.width(value: 8.0)),
                      borderSide: BorderSide(color: widget.borderColor ?? AppColors.instance.primary),
                    ),
                focusedBorder:
                    widget.border ??
                    OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSize.width(value: 8.0)),
                      borderSide: BorderSide(color: widget.borderColor ?? AppColors.instance.primary),
                    ),
                errorBorder:
                    widget.errBorder ??
                    OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSize.width(value: 8.0)),
                      borderSide: BorderSide(color: AppColors.instance.error),
                    ),
                focusedErrorBorder:
                    widget.errBorder ??
                    OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSize.width(value: 8.0)),
                      borderSide: BorderSide(color: AppColors.instance.error),
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

bool isValidEmail(String email) {
  final emailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+"
    r"@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$",
  );
  return emailRegex.hasMatch(email);
}
