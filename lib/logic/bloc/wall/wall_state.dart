part of 'wall_bloc.dart';

enum WallStatus { initial, success, failure }

class WallState extends Equatable {
  const WallState({
    this.status = WallStatus.initial,
    this.count = 0,
    this.posts = const <VKPost>[],
    this.offset = 0,
    this.hasReachedMax = false,
  });

  final WallStatus status;
  final int count;
  final List<VKPost> posts;
  final int offset;
  final bool hasReachedMax;

  WallState copyWith({
    WallStatus? status,
    int? count,
    List<VKPost>? posts,
    int? offset,
    bool? hasReachedMax,
  }) {
    return WallState(
      status: status ?? this.status,
      count: count ?? this.count,
      posts: posts ?? this.posts,
      offset: offset ?? this.offset,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, count: $count, offset: $offset, hasReachedMax: $hasReachedMax, posts: ${posts.length} }''';
  }

  @override
  List<Object?> get props => [status, count, posts, offset];
}
