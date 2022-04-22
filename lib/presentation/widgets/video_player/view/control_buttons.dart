import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vk_reels/logic/cubit/video_cubit.dart';
import 'package:vk_sdk/vk_sdk.dart';

class VideoControlButtons extends StatelessWidget {
  const VideoControlButtons({Key? key, required this.video}) : super(key: key);

  final VKVideo video;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoCubit, VideoState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            context.read<VideoCubit>().getVideoFile(video);
          },
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            child: const Icon(
              Icons.play_arrow_rounded,
              size: 64,
            ),
          ),
        );
      },
    );
  }
}
