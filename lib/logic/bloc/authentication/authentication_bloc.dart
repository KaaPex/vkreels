import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:insta_clone/constants/enums.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(AuthenticationState initialState) : super(initialState);

  AuthenticationState get initialState => AuthenticationUninitialized();
}
