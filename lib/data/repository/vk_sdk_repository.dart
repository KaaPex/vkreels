import 'package:async/async.dart';
import 'package:vk_sdk/vk_sdk.dart';

class VkSdkRepository {
  final VkSdk _vkSdk;
  VKAccessToken? _token;
  bool _sdkInitialized = false;

  VkSdkRepository({VkSdk? vkSdk}) : _vkSdk = vkSdk ?? VkSdk();

  Future<void> init() async {
    await _vkSdk.initSdk();
    _sdkInitialized = true;
    _token = await _vkSdk.accessToken;
  }

  Future<VKUserProfile?> getUserProfile() async {
    if (!_sdkInitialized) return null;

    final profileRes = _token != null ? await _vkSdk.getUserProfile() : null;

    return profileRes?.asValue?.value;
  }

  Future<Result<VKLoginResult>> logIn() async {
    final res = await _vkSdk.logIn(scope: [
      VKScope.email,
    ]);

    return res;
  }

  Future<void> logOut() async => await _vkSdk.logOut();

  static Future<bool> get isLoggedIn async => await VkSdk.isLoggedIn;
}
