import 'package:flutter/material.dart';
import 'package:flutter_riverpod_template/constant/app_asserts_icons_path.dart';
import 'package:flutter_riverpod_template/constant/app_colors.dart';

class CustomerFavoriteButton extends StatefulWidget {
  const CustomerFavoriteButton({super.key, this.isSelected = false, required this.onValueChange});
  final bool isSelected;
  final void Function(bool value) onValueChange;
  @override
  State<CustomerFavoriteButton> createState() => _CustomerFavoriteButtonState();
}

class _CustomerFavoriteButtonState extends State<CustomerFavoriteButton> {
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
        widget.onValueChange(isSelected);
      },
      overlayColor: WidgetStatePropertyAll(AppColors.instance.transparent),
      child: ImageIcon(
        AssetImage(isSelected ? AppAssertsIconsPath.instance.loveFill : AppAssertsIconsPath.instance.love),
        color: AppColors.instance.orange500,
      ),
    );
  }
}
