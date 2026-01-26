import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_template/constant/app_colors.dart';
import 'package:flutter_riverpod_template/constant/app_constant.dart';
import 'package:flutter_riverpod_template/utils/languages/language_provider.dart';
import 'package:flutter_riverpod_template/utils/languages/translation_cache.dart';
import 'package:translator/translator.dart';

class AppText extends ConsumerStatefulWidget {
  const AppText({
    super.key,
    required this.text,
    this.fontSize = 16,
    this.textScaleFactor = 0.9,
    this.color,
    this.fontWeight = FontWeight.w400,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.height,
    this.decoration,
    this.isDynamic = false,
    this.decorationColor,
  });
  final String text;
  final double? fontSize;
  final double textScaleFactor;
  final Color? color;
  final FontWeight? fontWeight;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final double? height;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final bool isDynamic;

  @override
  ConsumerState<AppText> createState() => _AppTextState();
}

class _AppTextState extends ConsumerState<AppText> {
  Future<String> _translateText(String lang) async {
    try {
      String targetLang = lang.split('_')[0].toLowerCase();

      // If English
      if (targetLang == "en") return widget.text;

      final cacheKey = "tr_${widget.text}_$targetLang";
      final cached = await TranslationCache.get(cacheKey);

      if (cached != null) return cached;

      final translator = GoogleTranslator();
      var translated = await translator.translate(widget.text, to: targetLang);

      await TranslationCache.set(cacheKey, translated.text);
      return translated.text;
    } catch (e) {
      return widget.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedLanguage = ref.watch(languageProvider);
    var style = Theme.of(context).textTheme.displaySmall?.copyWith(
      height: widget.height,
      fontSize: widget.fontSize,
      color: widget.color ?? AppColors.instance.black500,
      fontWeight: widget.fontWeight,
      fontFamily: AppConstant.instance.fontFamilyPoppins,
      decoration: widget.decoration,
      decorationColor: widget.decorationColor,
    );

    if (!widget.isDynamic) {
      return Text(
        widget.text,
        maxLines: widget.maxLines ?? 100,
        overflow: widget.overflow ?? TextOverflow.ellipsis,
        textAlign: widget.textAlign,
        style: style,
        textScaler: TextScaler.linear(widget.textScaleFactor),
      );
    }

    return FutureBuilder(
      key: ValueKey("${widget.text}_$selectedLanguage"),
      future: _translateText(selectedLanguage),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text(
            "...",
            maxLines: widget.maxLines,
            overflow: widget.overflow,
            textAlign: widget.textAlign,
            style: style,
            textScaler: TextScaler.linear(widget.textScaleFactor),
          );
        }
        final txt = snapshot.data ?? widget.text;

        return Text(txt, maxLines: widget.maxLines, overflow: widget.overflow, textAlign: widget.textAlign, style: style, textScaler: TextScaler.linear(widget.textScaleFactor));
      },
    );
  }
}
