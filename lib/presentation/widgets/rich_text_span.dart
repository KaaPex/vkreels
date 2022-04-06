import 'package:flutter/material.dart';

import 'link_text_span.dart';

class RichTextSpan extends StatelessWidget {
  final String text;

  const RichTextSpan({Key? key, required this.text}) : super(key: key);

  bool _isLink(String input) {
    final matcher =
        RegExp(r"(http(s)?:\/\/.)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)");
    return matcher.hasMatch(input);
  }

  bool _isHashTag(String input) {
    final matcher = RegExp(r"\B#([a-z0-9\u0430-\u044f]{2,})(?![~!@#$%^&*()=+_`\-\|\/'\[\]\{\}]|[?.,]*\w)");
    return matcher.hasMatch(input);
  }

  bool _isUsernameTag(String input) {
    final matcher = RegExp(r"\B@(?!.*\.\.)(?!.*\.$)[^\W][\w.]{0,29}$");
    return matcher.hasMatch(input);
  }

  bool _isUserLink(String input) {
    final matcher = RegExp(r"(?<=\[)(.*?)(?=\])");
    if (matcher.hasMatch(input)) {
      final value = matcher.firstMatch(input)?.group(0)?.split('|');
      // TODO: replace to profile link
    }
    return matcher.hasMatch(input);
  }

  @override
  Widget build(BuildContext context) {
    final _style = Theme.of(context).textTheme.bodyText2;
    final words = text.split(' ');
    List<TextSpan> span = [];
    for (var word in words) {
      if (_isHashTag(word)) {
        span.add(TextSpan(text: '$word ', style: _style?.copyWith(color: Colors.yellow)));
      } else if (_isUsernameTag(word)) {
        span.add(TextSpan(text: '$word ', style: _style?.copyWith(color: Colors.green)));
      } else if (_isUserLink(word)) {
        span.add(TextSpan(text: '$word ', style: _style?.copyWith(color: Colors.red)));
      } else if (_isLink(word)) {
        span.add(LinkTextSpan(text: '$word ', url: word, style: _style?.copyWith(color: Colors.blue)));
      } else {
        span.add(TextSpan(text: '$word ', style: _style));
      }
    }

    if (span.isNotEmpty) {
      return RichText(
        text: TextSpan(text: '', children: span),
      );
    } else {
      return Text(text);
    }
  }
}
