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

    if (userId == null) {
      return await _vkSdk.getUserProfile();
    } else {
      final builder = VkSdk.api.createMethodCall('users.get');
      builder.setValue('user_ids', userId);
      builder.setValue('fields', 'online,photo_50,photo_100,photo_200');
      final Result res = await builder.callMethod();
      return Result.value(VKUserProfile.fromJson(res.asValue?.value[0].cast<String, dynamic>()));
    }
  }

  Future<void> logIn() async {
    final Result<VKLoginResult> res = await _vkSdk.logIn(scope: [
      VKScope.email,
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
