import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_template/constant/app_colors.dart';
import 'package:flutter_riverpod_template/screens/base_screen/terms_and_conditions_screen/provider/terms_and_conditions_screen_provider.dart';
import 'package:flutter_riverpod_template/screens/base_screen/widgets/base_data_widget.dart';
import 'package:flutter_riverpod_template/screens/base_screen/widgets/base_no_found_data_widget.dart';
import 'package:flutter_riverpod_template/utils/app_size.dart';
import 'package:flutter_riverpod_template/widgets/texts/app_text.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.instance.white400,
      appBar: AppBar(
        centerTitle: true,
        title: AppText(text: "Terms & Conditions", fontWeight: FontWeight.w600),
        elevation: 2,
        shadowColor: AppColors.instance.dark300,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadiusGeometry.only(bottomLeft: Radius.circular(AppSize.width(value: 40)), bottomRight: Radius.circular(AppSize.width(value: 40))),
        ),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          var provider = ref.watch(termsAndConditionsScreenProvider);
          return provider.when(
            data: (data) {
              if (data.isEmpty) {
                return BaseNoFoundDataWidget();
              }
              return BaseDataWidget(data: data);
            },
            error: (error, stackTrace) => BaseNoFoundDataWidget(),
            loading: () => Skeletonizer(enabled: true, child: BaseNoFoundDataWidget()),
          );
        },
      ),
    );
  }
}
