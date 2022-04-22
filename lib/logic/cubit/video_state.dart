part of 'video_cubit.dart';

enum VideoStatus { initial, success, failure, playing, paused }

class VideoState extends Equatable {
  const VideoState({
    this.status = VideoStatus.initial,
    this.video = VKVideo.empty,
  });

  final VideoStatus status;
  final VKVideo video;

  VideoState copyWith({
    VideoStatus? status,
    VKVideo? video,
  }) {
    return VideoState(
      status: status ?? this.status,
      video: video ?? this.video,
    );
  }

  @override
  String toString() {
    return '''VideoState { status: $status, video: ${video.title} }''';
  }

  @override
  List<Object?> get props => [video];
}
