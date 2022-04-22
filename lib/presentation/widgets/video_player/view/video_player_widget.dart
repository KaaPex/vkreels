import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vk_reels/data/repository/vk_sdk_repository.dart';
import 'package:vk_reels/logic/cubit/video_cubit.dart';
import 'package:vk_sdk/vk_sdk.dart';

import 'control_buttons.dart';

class VideoPlayerWidget extends StatelessWidget {
  VideoPlayerWidget({Key? key, required this.video}) : super(key: key) {
    final index = video.image != null ? video.image!.length - 1 : 0;
    _thumbUrl = video.image![index].url;
  }

  final VKVideo video;
  late final String _thumbUrl;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VideoCubit>(
      create: (context) => VideoCubit(vkSdkRepository: context.read<VkSdkRepository>()),
      child: Stack(
        children: [
          Image.network(
            _thumbUrl,
            fit: BoxFit.cover,
          ),
          Text(video.title ?? ''),
          VideoControlButtons(
            video: video,
          ),
        ],
      ),
    );
  }
}
