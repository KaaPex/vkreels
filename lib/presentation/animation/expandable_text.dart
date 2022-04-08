import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui show PlaceholderAlignment;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vk_reels/presentation/widgets/rich_text_span.dart';

class ExpandableText extends StatefulWidget {
  const ExpandableText({Key? key, required this.author, required this.text}) : super(key: key);

  final String text;
  final String author;

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    var t = AppLocalizations.of(context)!;

    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutCirc,
      child: ConstrainedBox(
        constraints: isExpanded ? const BoxConstraints() : const BoxConstraints(maxHeight: 50.0),
        child: RichText(
          softWrap: true,
          text: TextSpan(
            children: [
              TextSpan(
                text: widget.author,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              // TextSpan(
              //   text: isExpanded ? widget.text : widget.text.substring(0, 50),
              // ),
              WidgetSpan(
                alignment: ui.PlaceholderAlignment.top,
                child: RichTextSpan(
                  text: isExpanded
                      ? widget.text
                      : widget.text.substring(0, widget.text.length >= 30 ? 30 : widget.text.length),
                ),
              ),
              isExpanded
                  ? const TextSpan()
                  : TextSpan(
                      text: t.more,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () => setState(() => isExpanded = true),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
