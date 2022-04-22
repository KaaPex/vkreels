import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vk_reels/data/repository/vk_sdk_repository.dart';
import 'package:vk_sdk/vk_sdk.dart';

part 'video_state.dart';

class VideoCubit extends Cubit<VideoState> {
  final VkSdkRepository _vkSdkRepository;

  VideoCubit({
    required VkSdkRepository vkSdkRepository,
  })  : _vkSdkRepository = vkSdkRepository,
        super(const VideoState());

  @override
  Future<void> close() {
    _vkSdkRepository.dispose();
    return super.close();
  }

  void getVideoFile(VKVideo file) async {
    final result =
        await _vkSdkRepository.getVideoById(ownerId: file.ownerId, videoId: file.id, accessKey: file.accessKey);
    if (result.isValue) {
      final VKVideo data = result.asValue!.value;
      emit(VideoState(video: data));
    }
  }
}
