import 'package:flutter/material.dart' hide Text;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_template/utils/app_log.dart';
import 'package:flutter_riverpod_template/utils/languages/language_provider.dart';
import 'package:flutter_riverpod_template/widgets/texts/app_text.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart';
import 'package:translator/translator.dart';

class AppHtmlWidget extends ConsumerStatefulWidget {
  const AppHtmlWidget({super.key, required this.html, this.textStyle, this.translate = true, this.isDynamic = true});

  final String html;
  final TextStyle? textStyle;
  final bool translate;
  final bool isDynamic;

  @override
  ConsumerState<AppHtmlWidget> createState() => _AppHtmlWidgetState();
}

class _AppHtmlWidgetState extends ConsumerState<AppHtmlWidget> {
  /// Translate HTML using Google Translator + SharedPreferences cache
  Future<String> _translateHtml(String langCode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final targetLang = langCode.split("_")[0].toLowerCase();

      // English → no translation
      if (targetLang == "en") return widget.html;

      final cacheKey = "html_translation_${widget.html.hashCode}_$targetLang";

      /// Read from cache
      final cached = prefs.getString(cacheKey);
      if (cached != null) return cached;

      final translator = GoogleTranslator();

      /// Parse HTML
      var document = html_parser.parse(widget.html);

      List<Text> textNodes = [];

      void extractTextNodes(Node node) {
        if (node is Text && node.text.trim().isNotEmpty) {
          textNodes.add(node);
        }
        for (var child in node.nodes) {
          extractTextNodes(child);
        }
      }

      extractTextNodes(document.body ?? document);

      /// Translate each text node
      if (textNodes.isNotEmpty) {
        await Future.wait(
          textNodes.map((node) async {
            try {
              var translated = await translator.translate(node.text, to: targetLang);
              node.text = translated.text;
            } catch (e) {
              errorLog("Translate node error", e);
            }
          }),
        );
      }

      final translatedHtml = document.outerHtml;

      /// Cache result
      await prefs.setString(cacheKey, translatedHtml);

      return translatedHtml;
    } catch (e) {
      errorLog("HTML translation failed", e);
      return widget.html;
    }
  }

  @override
  Widget build(BuildContext context) {
    final language = ref.watch(languageProvider);

    if (!widget.isDynamic) {
      return HtmlWidget(widget.html, textStyle: widget.textStyle, enableCaching: true);
    }

    return FutureBuilder<String>(
      key: ValueKey("${widget.html}_$language"),
      future: _translateHtml(language),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return AppText(text: "Loading...");
        }

        if (snapshot.hasError) {
          return HtmlWidget(widget.html, textStyle: widget.textStyle, enableCaching: true);
        }

        return HtmlWidget(snapshot.data ?? widget.html, textStyle: widget.textStyle, enableCaching: true);
      },
    );
  }
}
