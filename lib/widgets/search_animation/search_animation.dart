import 'package:flutter/material.dart';
import 'package:flutter_riverpod_template/constant/app_asserts_image_path.dart';
import 'package:flutter_riverpod_template/constant/app_colors.dart';
import 'package:flutter_riverpod_template/utils/app_size.dart';
import 'package:flutter_riverpod_template/widgets/app_image/app_image.dart';

class SearchAnimation extends StatefulWidget {
  final int waveCount;
  final double? maxRadius;
  final Duration duration;
  final Color? color;

  const SearchAnimation({super.key, this.waveCount = 4, this.maxRadius, this.duration = const Duration(seconds: 4), this.color});

  @override
  State<SearchAnimation> createState() => _SearchAnimationState();
}

class _SearchAnimationState extends State<SearchAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration)..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, -AppSize.width(value: 60)),
      child: SizedBox(
        width: (widget.maxRadius ?? AppSize.size.width) * 2,
        height: (widget.maxRadius ?? AppSize.size.width) * 2,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Create multiple waves
            for (int i = 0; i < widget.waveCount; i++)
              _RippleCircle(
                controller: _controller,
                delay: i / widget.waveCount,
                color: widget.color ?? AppColors.instance.gray300,
                maxRadius: (widget.maxRadius ?? AppSize.size.width),
              ),
            // Center widget (image, icon, etc.)
            Container(
              width: AppSize.size.width * 0.5,
              alignment: Alignment.center,
              padding: EdgeInsets.all(AppSize.size.width * 0.07),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.instance.blue500, width: 5),
                color: AppColors.instance.gray700,
              ),
              child: AppImage(fit: BoxFit.fill, path: AppAssertsImagePath.instance.networkPlaceholderImage),
            ),
          ],
        ),
      ),
    );
  }
}

class _RippleCircle extends StatelessWidget {
  final AnimationController controller;
  final double delay;
  final Color color;
  final double maxRadius;

  const _RippleCircle({required this.controller, required this.delay, required this.color, required this.maxRadius});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, _) {
        double progress = (controller.value + delay) % 1.0;

        double size = progress * maxRadius;
        double opacity = (1 - progress).clamp(0.0, 1.0);

        return Opacity(
          opacity: opacity,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color.withValues(alpha: 0.4)),
          ),
        );
      },
    );
  }
}
