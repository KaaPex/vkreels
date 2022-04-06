part of 'wall_cubit.dart';

@immutable
class WallState extends Equatable {
  final int count;
  final List<VKPost> posts;
  final int offset;

  const WallState({this.count = 0, this.posts = const [], this.offset = 0});

  @override
  List<Object?> get props => [count, posts, offset];
}
