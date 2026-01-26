import 'package:flutter/material.dart';
import 'package:flutter_riverpod_template/constant/app_colors.dart';
import 'package:flutter_riverpod_template/constant/app_constant.dart';
import 'package:flutter_riverpod_template/utils/app_size.dart';
import 'package:flutter_riverpod_template/widgets/texts/app_html_text.dart';

class BaseDataWidget extends StatelessWidget {
  const BaseDataWidget({super.key, required this.data});
  final String data;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: AppSize.width(value: 20.0)),
      padding: EdgeInsets.symmetric(horizontal: AppSize.width(value: 20.0), vertical: AppSize.width(value: 20.0)),
      width: AppSize.size.width,
      height: AppSize.size.height,
      decoration: BoxDecoration(
        color: AppColors.instance.white50,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(AppSize.width(value: 20.0)), topRight: Radius.circular(AppSize.width(value: 20.0))),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(AppSize.width(value: 20)),

        child: AppHtmlWidget(
          html: data,
          textStyle: TextStyle(fontFamily: AppConstant.instance.font, height: 1.5, color: AppColors.instance.dark600),
        ),
      ),
    );
  }
}
