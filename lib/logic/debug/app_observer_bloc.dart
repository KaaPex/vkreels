import 'package:bloc/bloc.dart';
import 'dart:developer' as developer;

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    developer.log('onCreate', name: bloc.toString());
    super.onCreate(bloc);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    developer.log(change.hashCode.toString(), name: bloc.toString());
    super.onChange(bloc, change);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    developer.log(event.toString(), name: bloc.toString());
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    developer.log('Error', name: bloc.toString(), stackTrace: stackTrace, error: error);
    super.onError(bloc, error, stackTrace);
  }
}
