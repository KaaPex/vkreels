import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vk_reels/data/repository/vk_sdk_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final VkSdkRepository _vkSdkRepository;

  LoginBloc({
    required VkSdkRepository vkSdkRepository,
  })  : _vkSdkRepository = vkSdkRepository,
        super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<LogoutButtonPressed>(_onLogoutButtonPressed);
  }

  void _onLoginButtonPressed(LoginButtonPressed event, Emitter<LoginState> emit) async {
    try {
      await _vkSdkRepository.logIn();
      emit(LoginLoading());
    } catch (error) {
      emit(LoginFailure(error: error.toString()));
    }
  }

  void _onLogoutButtonPressed(LogoutButtonPressed event, Emitter<LoginState> emit) async {
    try {
      await _vkSdkRepository.logOut();
      emit(LoginInitial());
    } catch (_) {}
  }
}
