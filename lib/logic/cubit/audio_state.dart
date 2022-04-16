part of 'audio_cubit.dart';

class AudioState extends Equatable {
  const AudioState({
    this.files = const <VKAudio>[],
  });

  final List<VKAudio> files;

  @override
  List<Object?> get props => [files];
}
