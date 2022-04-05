part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class ProfileDataRequested extends ProfileEvent {
  final int? userId;

  const ProfileDataRequested(this.userId);

  @override
  String toString() => 'ProfileDataRequested { user_id: $userId }';

  @override
  List<Object?> get props => [userId];
}

class ProfileDataReceived extends ProfileEvent {
  @override
  String toString() => 'ProfileDataReceived';
}
