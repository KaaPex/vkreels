part of 'internet_cubit.dart';

abstract class InternetState extends Equatable {
  @override
  List<Object> get props => [];
}

class InternetLoading extends InternetState {}

class InternetConnected extends InternetState {
  final ConnectionType connectionType;

  InternetConnected({required this.connectionType});
}

class InternetDisconnected extends InternetState {}
