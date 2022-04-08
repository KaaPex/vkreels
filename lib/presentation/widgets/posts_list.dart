import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vk_reels/logic/cubit/cubit.dart';
import 'package:vk_reels/presentation/widgets/post_card.dart';

import 'bottom_loader.dart';

class PostsList extends StatefulWidget {
  const PostsList({Key? key, required this.id}) : super(key: key);

  final int? id;

  @override
  State<PostsList> createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WallCubit, WallState>(
      builder: (context, state) {
        return state.posts.isNotEmpty
            ? ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return index >= state.posts.length ? const BottomLoader() : PostCard(post: state.posts[index]);
                },
                itemCount: state.hasReachedMax ? state.posts.length : state.posts.length + 1,
                controller: _scrollController,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
              )
            : const Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<WallCubit>().getUserPosts(widget.id);
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
