part of 'wall_cubit.dart';

@immutable
class WallState extends Equatable {
  const WallState({
    this.count = 0,
    this.posts = const <VKPost>[],
    this.offset = 0,
    this.hasReachedMax = false,
  });

  final int count;
  final List<VKPost> posts;
  final int offset;
  final bool hasReachedMax;

  WallState copyWith({
    int? count,
    List<VKPost>? posts,
    int? offset,
    bool? hasReachedMax,
  }) {
    return WallState(
      count: count ?? this.count,
      posts: posts ?? this.posts,
      offset: count ?? this.offset,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''PostState { count: $count, offset: $offset, hasReachedMax: $hasReachedMax, posts: ${posts.length} }''';
  }

  @override
  List<Object?> get props => [count, posts, offset];
}
