import 'package:flutter/material.dart';
import 'package:flutter_riverpod_template/constant/app_colors.dart';
import 'package:flutter_riverpod_template/screens/base_screen/faq_screen/models/f_a_q_screen_data_model.dart';
import 'package:flutter_riverpod_template/utils/app_size.dart';
import 'package:flutter_riverpod_template/utils/gap.dart';
import 'package:flutter_riverpod_template/widgets/texts/app_text.dart';

class FaqCard extends StatelessWidget {
  const FaqCard({super.key, required this.onTap, required this.item});
  final FAQScreenDataModel item;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      overlayColor: WidgetStatePropertyAll(Colors.transparent),
      child: Container(
        margin: EdgeInsets.only(bottom: AppSize.size.width * 0.02),
        padding: EdgeInsets.symmetric(horizontal: AppSize.size.width * 0.05, vertical: AppSize.size.width * 0.015),
        decoration: BoxDecoration(
          color: AppColors.instance.white400,
          border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
          borderRadius: BorderRadius.circular(AppSize.size.width * 0.02),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: AppText(
                    text: item.title,
                    color: AppColors.instance.dark400,
                    fontWeight: FontWeight.w600,
                    fontSize: AppSize.size.width * 0.05,
                    textAlign: TextAlign.start,
                    height: 1.5,
                  ),
                ),
                Gap(width: 20),
                AnimatedRotation(
                  duration: Durations.medium4,
                  turns: item.isSelected ? 0.75 : 0.25,
                  child: Icon(Icons.arrow_forward_ios, color: AppColors.instance.dark400, weight: 500),
                ),
              ],
            ),

            AnimatedSize(
              duration: Durations.medium4,
              curve: Curves.easeInOut,
              child: ConstrainedBox(
                constraints: item.isSelected ? const BoxConstraints() : const BoxConstraints(maxHeight: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(height: 20),
                    AppText(text: item.body, height: 1.5, fontSize: AppSize.size.width * 0.05, color: AppColors.instance.dark400, maxLines: 50000, textAlign: TextAlign.start),
                    Gap(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
