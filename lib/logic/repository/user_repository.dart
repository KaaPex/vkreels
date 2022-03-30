import 'package:vk_sdk/vk_sdk.dart';

class UserRepository {
  final _vkSdk = VkSdk(debug: true);

  VKAccessToken? _token;
  VKUserProfile? _user;
  bool _sdkInitialized = false;

  Future<VKAccessToken?> authenticate() async {
    await _vkSdk.initSdk();
    _sdkInitialized = true;
    _token = await _vkSdk.accessToken;
    return _token;
  }

  Future<VKUserProfile?> getUser() async {
    if (!_sdkInitialized) return null;

    final profileRes = _token != null ? await _vkSdk.getUserProfile() : null;

    return profileRes?.asValue?.value;
  }
}
