import 'package:async/async.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vk_reels/data/repository/vk_sdk_repository.dart';
import 'package:vk_sdk/vk_sdk.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final VkSdkRepository _vkSdkRepository;

  ProfileBloc({
    required VkSdkRepository vkSdkRepository,
  })  : _vkSdkRepository = vkSdkRepository,
        super(const ProfileState.loading()) {
    on<ProfileDataRequested>(_profileDataRequested);
  }

  void _profileDataRequested(ProfileDataRequested event, Emitter<ProfileState> emit) async {
    emit(const ProfileState.loading());

    try {
      final result = await _vkSdkRepository.getUserProfile(userId: event.userId);

      if (result.isError) {
        throw result.asError!.error;
      } else {
        emit(ProfileState.loaded(result.asValue!.value!));
      }
    } catch (error) {
      emit(ProfileState.error(ErrorResult(error)));
    }
  }
}
