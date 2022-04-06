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
    final result = await _vkSdkRepository.getUserPosts(userId: userId);
    final VKWall? wall = result.asValue?.value;
    final List<VKPost> posts = List<VKPost>.from(state.posts);
    posts.addAll(wall?.items ?? []);
    emit(WallState(count: wall?.count ?? 0, offset: state.offset + (wall?.items.length ?? 0), posts: posts));
  }
}
