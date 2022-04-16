import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vk_reels/data/repository/vk_sdk_repository.dart';
import 'package:vk_sdk/vk_sdk.dart';

part 'audio_state.dart';

class AudioCubit extends Cubit<AudioState> {
  final VkSdkRepository _vkSdkRepository;

  AudioCubit({
    required VkSdkRepository vkSdkRepository,
  })  : _vkSdkRepository = vkSdkRepository,
        super(const AudioState());

  @override
  Future<void> close() {
    _vkSdkRepository.dispose();
    return super.close();
  }

  void getAudioFiles(List<VKAudio> files) async {
    final String ids = files.map((e) => '${e.ownerId}_${e.id}').join(',');
    final result = await _vkSdkRepository.getAudioById(ids);
    if (result.isValue) {
      final List<VKAudio> data = result.asValue!.value;
      emit(AudioState(files: data));
    }
  }
}
