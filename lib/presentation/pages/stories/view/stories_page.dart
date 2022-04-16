import 'package:flutter/material.dart';
import 'package:vk_reels/presentation/widgets/posts_list.dart';

class StoriesPage extends StatelessWidget {
  const StoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PostsList(
        id: 844449,
      ),
      // body: PostsList(id: 2867087,),
    );
  }
}
