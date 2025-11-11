import 'package:flutter/material.dart';
import 'package:flutter_riverpod_template/utils/app_size.dart';

class AppOverlayHelper {
  static OverlayEntry? _overlayEntry;
  static late AnimationController _controller;
  static late Animation<Offset> _animation;

  static void show(BuildContext context, Widget child) async {
    if (_overlayEntry != null) {
      await _controller.reverse();
      _overlayEntry?.remove();
      _overlayEntry = null;
      return;
    }

    final overlay = Overlay.of(context);
    _controller = AnimationController(vsync: Navigator.of(context), duration: const Duration(milliseconds: 400));

    _animation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _overlayEntry = OverlayEntry(
      builder: (_) => Stack(
        children: [
          GestureDetector(
            onTap: () => close(),
            child: Container(color: Colors.transparent),
          ),
          // Dialog
          Positioned.fill(
            child: SlideTransition(
              position: _animation,
              child: Align(
                alignment: Alignment.topCenter,
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  child: SizedBox(height: AppSize.size.height, width: AppSize.size.width, child: child),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    overlay.insert(_overlayEntry!);
    _controller.forward();
  }

  static void close() async {
    if (_overlayEntry == null) return;
    await _controller.reverse();
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
