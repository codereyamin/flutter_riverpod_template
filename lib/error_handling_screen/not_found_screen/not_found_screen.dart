import 'package:flutter/material.dart';
import 'package:flutter_riverpod_template/constant/app_colors.dart';
import 'package:flutter_riverpod_template/routes/app_routes.dart';
import 'package:flutter_riverpod_template/utils/app_size.dart';
import 'package:flutter_riverpod_template/utils/gap.dart';
import 'package:flutter_riverpod_template/widgets/app_image/app_image.dart';
import 'package:flutter_riverpod_template/widgets/buttons/app_button.dart';
import 'package:flutter_riverpod_template/widgets/texts/app_text.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppSize.size.width * 0.25),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(AppSize.width(value: 10)),
            child: FittedBox(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: AppSize.width(value: 5),
                children: [
                  AppText(text: "404", fontWeight: FontWeight.bold, fontSize: AppSize.width(value: 40)),
                  AppText(text: "Page Not Found!", fontWeight: FontWeight.bold, color: AppColors.instance.white400, fontSize: AppSize.width(value: 20)),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: AppSize.width(value: 5),
          children: [
            AppImage(path: "assets/images/not_found.webp", width: AppSize.size.width * 0.6),

            Gap(height: 5),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSize.size.width * 0.1),
              child: AppText(text: "We're sorry, the page you requested could not be found. Please go back to the homepage!", textAlign: TextAlign.center, height: 1.5),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: AppSize.width(value: 40)),
          child: AppButton(
            onTap: () {
              AppRoutes.instance.pop();
            },
            height: AppSize.width(value: 50),
            margin: EdgeInsets.symmetric(horizontal: AppSize.width(value: 20)),
            titleColor: AppColors.instance.textBlack500,
            title: "Return to Back",
          ),
        ),
      ),
    );
  }
}
