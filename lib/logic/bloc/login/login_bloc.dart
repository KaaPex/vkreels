import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vk_sdk/vk_sdk.dart';

import '../authentication/authentication_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final VkSdk vkSdk;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    required this.vkSdk,
    required this.authenticationBloc,
  }) : super(LoginInitial());

  LoginState get initialState => LoginInitial();
}
