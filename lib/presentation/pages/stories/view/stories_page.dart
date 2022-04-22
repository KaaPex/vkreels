import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vk_reels/data/repository/vk_sdk_repository.dart';
import 'package:vk_reels/logic/bloc/bloc.dart';
import 'package:vk_reels/presentation/widgets/posts_list.dart';

class StoriesPage extends StatelessWidget {
  const StoriesPage({Key? key}) : super(key: key);

  static const routeName = '/stories';

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const StoriesPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<WallBloc>(
        create: (context) => WallBloc(vkSdkRepository: context.read<VkSdkRepository>())..add(const WallFetched(844449)),
        child: const PostsList(
          id: 844449,
        ),
      ),
      // body: PostsList(id: 2867087,),
    );
  }
}
