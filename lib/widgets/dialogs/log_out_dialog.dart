import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_template/constant/app_colors.dart';
import 'package:flutter_riverpod_template/routes/app_routes.dart';
import 'package:flutter_riverpod_template/utils/app_log.dart';
import 'package:flutter_riverpod_template/utils/app_size.dart';
import 'package:flutter_riverpod_template/utils/gap.dart';
import 'package:flutter_riverpod_template/widgets/buttons/app_button.dart';
import 'package:flutter_riverpod_template/widgets/texts/app_text.dart';

void callLogOutDialog() {
  try {
    showAdaptiveDialog(
      context: rootNavigatorKey.currentContext!,
      builder: (context) => Material(
        color: AppColors.instance.transparent,
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          overlayColor: WidgetStatePropertyAll(AppColors.instance.transparent),
          child: Center(child: LogOutDialog()),
        ),
      ),
    );
  } catch (e) {
    errorLog("message", e);
  }
}

class LogOutDialog extends StatelessWidget {
  const LogOutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.size.width * 0.75,
      padding: EdgeInsets.all(AppSize.width(value: 25.0)),
      decoration: BoxDecoration(color: AppColors.instance.gray700, borderRadius: BorderRadius.circular(AppSize.width(value: 15.0))),
      child: Column(
        spacing: AppSize.width(value: 10),
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText(
            text: "Are you sure you want to logout?",
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w500,
            height: 1.6,
            fontSize: AppSize.width(value: 18),
          ),
          Gap(height: 10),
          Row(
            children: [
              Expanded(
                child: AppButton(backgroundColor: AppColors.instance.gray700, borderColor: AppColors.instance.white50, title: "Cancel"),
              ),
              Gap(width: 20),
              Expanded(
                child: Consumer(
                  builder: (context, ref, child) {
                    return AppButton(onTap: () {}, title: "Confirm");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
