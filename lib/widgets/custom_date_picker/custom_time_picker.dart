import 'package:flutter/material.dart';
import 'package:flutter_riverpod_template/constant/app_colors.dart';
import 'package:flutter_riverpod_template/utils/app_log.dart';

Future<void> customTimePicker({
  required BuildContext context,
  required Function(TimeOfDay?) onTimeSelected,
  bool alwaysUse24HourFormat = false,
}) async {
  try {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: alwaysUse24HourFormat),
          child: Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(primary: AppColors.instance.primary, onPrimary: AppColors.instance.black900, onSurface: Colors.black),
              timePickerTheme: TimePickerThemeData(
                backgroundColor: AppColors.instance.primary, // Main background color
                hourMinuteTextColor: Colors.black, // Text color for hour and minute
                hourMinuteColor: AppColors.instance.primary, // Background color for hour and minute
                dayPeriodColor: WidgetStateColor.resolveWith(
                  (states) => states.contains(WidgetState.selected)
                      ? AppColors
                            .instance
                            .primary // Selected AM/PM color
                      : AppColors.instance.primary,
                ), // Unselected AM/PM color
                // dayPeriodTextColor: WidgetStateColor.resolveWith((states) => states.contains(WidgetState.selected)
                //     ? Colors.white // Text color when AM/PM is selected
                //     : Colors.black),
                //// Text color when AM/PM is not selected
                dayPeriodTextColor: WidgetStateColor.resolveWith((states) => Colors.black),
                dialBackgroundColor: AppColors.instance.primary,
                dayPeriodBorderSide: BorderSide(
                  color: AppColors.instance.primary, // Custom border color for AM/PM selector
                  width: 2, // Border width
                ),
              ),
            ),
            child: child!,
          ),
        );
      },
    );
    if (pickedTime != null) {
      onTimeSelected(pickedTime);
    }
  } catch (e) {
    errorLog("customTimePicker", e);
  }
}
