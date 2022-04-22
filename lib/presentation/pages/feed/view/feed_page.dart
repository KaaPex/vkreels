import 'package:flutter/material.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({Key? key}) : super(key: key);

  static const routeName = '/feed';

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const FeedPage());
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
