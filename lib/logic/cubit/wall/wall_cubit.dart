import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vk_reels/data/repository/vk_sdk_repository.dart';
import 'package:vk_sdk/vk_sdk.dart';

part 'wall_state.dart';

class WallCubit extends Cubit<WallState> {
  final VkSdkRepository _vkSdkRepository;
  WallCubit({
    required VkSdkRepository vkSdkRepository,
  })  : _vkSdkRepository = vkSdkRepository,
        super(const WallState());

  @override
  Future<void> close() {
    _vkSdkRepository.dispose();
    return super.close();
  }

  void getUserPosts(int? userId) async {
    final result = await _vkSdkRepository.getUserPosts(userId: userId, offset: state.offset);
    final VKWall? wall = result.asValue?.value;
    final int len = wall?.items.length ?? 0;
    len == 0
        ? emit(state.copyWith(hasReachedMax: true))
        : emit(state.copyWith(count: wall?.count ?? 0, offset: state.offset + len, posts: wall?.items));
  }
}
