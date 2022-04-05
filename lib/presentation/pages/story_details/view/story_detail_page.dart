import 'package:flutter/material.dart';

class StoryDetailPage extends StatelessWidget {
  const StoryDetailPage({Key? key}) : super(key: key);

  static const routeName = '/story';

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const StoryDetailPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('StoryDetailPage'),
        ],
      ),
    );
  }
}
