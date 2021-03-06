import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vk_reels/core/constants/enums.dart';
import 'package:vk_reels/data/repository/vk_sdk_repository.dart';

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
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        emit(const AuthenticationState.unauthenticated());
        break;
      case AuthenticationStatus.authenticated:
        final userId = await VkSdkRepository.userId;
        emit(userId != null ? AuthenticationState.authenticated(userId) : const AuthenticationState.unauthenticated());
        break;
      default:
        emit(const AuthenticationState.unknown());
    }
  }
}
