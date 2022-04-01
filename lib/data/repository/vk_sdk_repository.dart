import 'dart:async';

import 'package:async/async.dart';
import 'package:vk_sdk/vk_sdk.dart';

import '../../core/constants/enums.dart';

class VkSdkRepository {
  final _controller = StreamController<AuthenticationStatus>();
  final VkSdk _vkSdk;
  bool _sdkInitialized = false;

  VkSdkRepository({VkSdk? vkSdk}) : _vkSdk = vkSdk ?? VkSdk();

  Future<void> init() async {
    await _vkSdk.initSdk();
    _sdkInitialized = true;
  }

  Stream<AuthenticationStatus> get status async* {
    yield AuthenticationStatus.unknown;
    yield* _controller.stream;
  }

  Future<VKUserProfile?> getUserProfile() async {
    if (!_sdkInitialized) return null;

    final profileRes = await VkSdkRepository.isLoggedIn ? await _vkSdk.getUserProfile() : null;

    return profileRes?.asValue?.value;
  }

  Future<void> logIn() async {
    final Result<VKLoginResult> res = await _vkSdk.logIn(scope: [
      VKScope.email,
    ]);

    if (res.isError) {
    } else {
      final loginResult = res.asValue!.value;
      if (!loginResult.isCanceled) {
        _controller.add(AuthenticationStatus.authenticated);
      } else {
        _controller.add(AuthenticationStatus.unauthenticated);
      }
    }
  }

  Future<void> logOut() async {
    await _vkSdk.logOut();
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  static Future<bool> get isLoggedIn async => await VkSdk.isLoggedIn;

  void dispose() => _controller.close();
}
