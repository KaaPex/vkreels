import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:vk_reels/data/repository/vk_sdk_repository.dart';
import 'package:vk_sdk/vk_sdk.dart';

part 'wall_event.dart';
part 'wall_state.dart';

const throttleDuration = Duration(milliseconds: 1000);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class WallBloc extends Bloc<WallEvent, WallState> {
  final VkSdkRepository _vkSdkRepository;

  WallBloc({
    required VkSdkRepository vkSdkRepository,
  })  : _vkSdkRepository = vkSdkRepository,
        super(const WallState()) {
    on<WallFetched>(
      (event, emit) {
        _onGetWallData(event.userId);
      },
      transformer: throttleDroppable(throttleDuration),
    );
  }

  @override
  Future<void> close() {
    _vkSdkRepository.dispose();
    return super.close();
  }

  void _onGetWallData(int? userId) async {
    final result = await _vkSdkRepository.getUserPosts(userId: userId, count: 10, offset: state.offset);
    if (result.isValue) {
      final VKWall? wall = result.asValue?.value;
      final int len = wall?.items.length ?? 0;
      final List<VKPost> posts = List<VKPost>.from(state.posts)..addAll(wall?.items ?? []);
      len < 10
          ? emit(state.copyWith(status: WallStatus.success, posts: posts, hasReachedMax: true))
          : emit(state.copyWith(
              status: WallStatus.success, count: wall?.count ?? 0, offset: state.offset + len, posts: posts));
    } else {
      emit(state.copyWith(status: WallStatus.failure));
    }
  }
}
