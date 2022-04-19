part of 'wall_bloc.dart';

abstract class WallEvent extends Equatable {
  const WallEvent();

  @override
  List<Object?> get props => [];
}

class WallFetched extends WallEvent {
  final int? userId;

  const WallFetched(this.userId);

  @override
  String toString() => 'WallFetched { user_id: $userId }';

  @override
  List<Object?> get props => [userId];
}
