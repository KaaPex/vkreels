import 'dart:async';

import 'package:insta_clone/core/constants/enums.dart';
import 'package:vk_sdk/vk_sdk.dart';

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    final bool isLoggedIn = await VkSdk.isLoggedIn;
    yield isLoggedIn
        ? AuthenticationStatus.authenticated
        : AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }
}
