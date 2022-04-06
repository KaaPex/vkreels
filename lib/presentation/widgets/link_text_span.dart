import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void _launchURL(String url) async {
  if (!await launch(url)) throw 'Could not launch $url';
}

class LinkTextSpan extends TextSpan {
  LinkTextSpan({TextStyle? style, String url = '', String? text})
      : super(style: style, text: text ?? url, recognizer: TapGestureRecognizer()..onTap = () => _launchURL(url));
}
