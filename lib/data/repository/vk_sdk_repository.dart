import 'dart:async';

import 'package:async/async.dart';
import 'package:vk_sdk/vk_sdk.dart';

import '../../core/constants/enums.dart';

class VkSdkRepository {
  final _authController = StreamController<AuthenticationStatus>();
  final VkSdk _vkSdk;
  bool _sdkInitialized = false;

  VkSdkRepository({VkSdk? vkSdk}) : _vkSdk = vkSdk ?? VkSdk();

  Future<void> init() async {
    await _vkSdk.initSdk();
    _sdkInitialized = true;
  }

  Stream<AuthenticationStatus> get status async* {
    // delay for to show logo page
    await Future<void>.delayed(const Duration(seconds: 1));
    if (!_sdkInitialized) yield AuthenticationStatus.unknown;
    final bool isLoggedIn = await VkSdk.isLoggedIn;
    yield isLoggedIn ? AuthenticationStatus.authenticated : AuthenticationStatus.unauthenticated;
    yield* _authController.stream;
  }

  Future<Result<VKUserProfile?>> getUserProfile({int? userId}) async {
    if (!_sdkInitialized) return Result.value(VKUserProfile.empty);

    try {
      if (userId == null) {
        return await _vkSdk.getUserProfile();
      } else {
        final builder = VkSdk.api.createMethodCall('users.get');
        builder.setValue('user_ids', userId);
        builder.setValue(
            'fields', 'online,photo_50,photo_100,photo_200,counters,nickname,domain,screen_name,status,status_audio');
        final Result res = await builder.callMethod();
        final value = VKUserProfile.fromJson(res.asValue?.value[0].cast<String, dynamic>());
        return Result.value(value);
      }
    } catch (error) {
      return Result.error(error);
    }
  }

  VKPost _fillGroupData(VKPost post, List<VKUserProfile?>? profiles, List<VKGroup?>? groups) {
    final VKUserProfile? profile = profiles?.firstWhere(
      (element) => element?.userId == post.ownerId.abs(),
      orElse: () => null,
    );
    final VKGroup? group = groups?.firstWhere(
      (element) => element?.id == post.ownerId.abs(),
      orElse: () => null,
    );

    final List<VKPost> filledReposts = [];
    post.copyHistory?.forEach((repost) => filledReposts.add(_fillGroupData(repost, profiles, groups)));

    return post.copyWith(
      profile: profile,
      group: group,
      copyHistory: filledReposts.isNotEmpty ? filledReposts : null,
    );
  }

  Future<Result<VKWall?>> getUserPosts({int? userId, String? domain, int? count, int? offset}) async {
    if (!_sdkInitialized) return Result.value(VKWall.empty);
    const defaultCount = 10;

    try {
      final builder = VkSdk.api.createMethodCall('wall.get');
      builder.setValue('fields', 'attachments');
      builder.setValue('extended', 1);
      builder.setValue('fields', 'photo_50,screen_name');
      if (userId != null) {
        builder.setValue('owner_id', userId);
      }

      if (domain != null) {
        builder.setValue('domain', domain);
      }

      builder.setValue('count', count ?? defaultCount);

      if (offset != null) {
        builder.setValue('offset', offset);
      }

      final Result res = await builder.callMethod();
      final data = VKWall.fromJson(res.asValue?.value.cast<String, dynamic>());
      // fill post profile and group data
      final List<VKPost> filledItems = [];
      for (var item in data.items) {
        filledItems.add(
          _fillGroupData(item, data.profiles, data.groups),
        );
      }

      return Result.value(VKWall(data.count, filledItems));
    } catch (error) {
      return Result.error(error);
    }
  }

  Future<Result<List<VKAudio>>> getAudioById(String audioIds) async {
    if (!_sdkInitialized || audioIds == null || audioIds.isEmpty) {
      return Result.value(List.empty());
    }

    try {
      final builder = VkSdk.api.createMethodCall('audio.getById');
      builder.setValue('audios', audioIds);
      final Result res = await builder.callMethod();
      if (res.isValue) {
        final data = (res as List<dynamic>)
            .map(
              (item) => VKAudio.fromJson(item as Map<String, dynamic>),
            )
            .toList();
        return Result.value(data);
      } else {
        return Result.error(res);
      }
    } catch (error) {
      return Result.error(error);
    }
  }

  Future<Result<List<VKUserProfile>>> getUserSubscriptions({int? userId}) async {
    if (!_sdkInitialized) return Result.value(List.empty());

    final builder = VkSdk.api.createMethodCall('users.getSubscriptions');
    builder.setValue('user_id', userId);
    final Result res = await builder.callMethod();

    return Result.value(List.empty());
  }

  Future<void> logIn() async {
    final Result<VKLoginResult> res = await _vkSdk.logIn(scope: [
      VKScope.email,
      VKScope.audio,
      VKScope.video,
    ]);

    if (res.isError) {
      _authController.add(AuthenticationStatus.unauthenticated);
    } else {
      final loginResult = res.asValue!.value;
      if (!loginResult.isCanceled) {
        _authController.add(AuthenticationStatus.authenticated);
      } else {
        _authController.add(AuthenticationStatus.unauthenticated);
      }
    }
  }

  Future<void> logOut() async {
    await _vkSdk.logOut();
    _authController.add(AuthenticationStatus.unauthenticated);
  }

  static Future<bool> get isLoggedIn async => await VkSdk.isLoggedIn;

  static Future<int?> get userId async => await VkSdk.userId;

  void dispose() => _authController.close();
}
