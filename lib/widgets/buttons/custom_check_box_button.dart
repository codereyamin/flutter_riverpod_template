import 'package:flutter/material.dart';
import 'package:flutter_riverpod_template/constant/app_colors.dart';
import 'package:flutter_riverpod_template/utils/app_log.dart';
import 'package:flutter_riverpod_template/utils/app_size.dart';

class CustomCheckBoxButton extends StatefulWidget {
  const CustomCheckBoxButton({super.key, this.value, required this.onChange, this.color});
  final Function(bool value) onChange;
  final bool? value;
  final Color? color;
  @override
  State<CustomCheckBoxButton> createState() => _CustomCheckBoxButtonState();
}

class _CustomCheckBoxButtonState extends State<CustomCheckBoxButton> {
  bool isValue = false;
  void setFunction() {
    try {
      isValue = widget.value ?? false;
    } catch (e) {
      errorLog("setFunction", e);
    }
  }

  void onAppChange(CustomCheckBoxButton oldWidget) {
    try {
      if (oldWidget.value != widget.value) {
        setState(() {
          isValue = widget.value ?? false;
        });
      }
    } catch (e) {
      errorLog('onAppChange', e);
    }
  }

  @override
  void initState() {
    super.initState();
    setFunction();
  }

  @override
  void didUpdateWidget(covariant CustomCheckBoxButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    onAppChange(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.2,
      child: Theme(
        data: ThemeData(unselectedWidgetColor: AppColors.instance.purple500),
        child: Checkbox(
          activeColor: AppColors.instance.white50,
          visualDensity: VisualDensity(horizontal: -4, vertical: -4),
          side: WidgetStateBorderSide.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return BorderSide(color: isValue ? widget.color ?? AppColors.instance.purple500 : AppColors.instance.white500);
            } else {
              return BorderSide(color: AppColors.instance.gray200);
            }
          }),
          value: isValue,
          checkColor: widget.color ?? AppColors.instance.purple500,
          fillColor: WidgetStatePropertyAll(AppColors.instance.white50),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: widget.color ?? AppColors.instance.purple500),
            borderRadius: BorderRadius.circular(AppSize.width(value: 5.0)),
          ),
          onChanged: (value) {
            setState(() {
              isValue = !isValue;
            });
            widget.onChange(isValue);
          },
        ),
      ),
    );
  }
}
