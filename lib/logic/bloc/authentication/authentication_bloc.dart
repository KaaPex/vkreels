import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vk_reels/core/constants/enums.dart';
import 'package:vk_reels/data/repository/vk_sdk_repository.dart';
import 'package:vk_sdk/vk_sdk.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({required VkSdkRepository vkSdkRepository})
      : _vkSdkRepository = vkSdkRepository,
        super(const AuthenticationState.unknown()) {
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    _authenticationStatusSubscription = _vkSdkRepository.status.listen(
      (status) => add(AuthenticationStatusChanged(status)),
    );
  }

  final VkSdkRepository _vkSdkRepository;
  late StreamSubscription<AuthenticationStatus> _authenticationStatusSubscription;

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _vkSdkRepository.dispose();
    return super.close();
  }

  void _onAuthenticationStatusChanged(
    AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    print(event);
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthenticationState.unauthenticated());
      case AuthenticationStatus.authenticated:
        final VKUserProfile? user;
        try {
          user = await _vkSdkRepository.getUserProfile();
          return emit(
              user != null ? AuthenticationState.authenticated(user) : const AuthenticationState.unauthenticated());
        } catch (_) {
          return emit(const AuthenticationState.unauthenticated());
        }
      default:
        return emit(const AuthenticationState.unknown());
    }
  }
}
