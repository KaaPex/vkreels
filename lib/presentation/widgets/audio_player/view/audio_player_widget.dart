import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vk_sdk/vk_sdk.dart';

import '../models/position_data.dart';
import 'control_buttons.dart';
import 'seek_bar.dart';

class AudioPlayerWidget extends StatefulWidget {
  const AudioPlayerWidget({Key? key, required this.files}) : super(key: key);

  final List<VKAudio> files;

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> with WidgetsBindingObserver {
  late AudioPlayer _player;
  late var _playlist;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    _player = AudioPlayer();
    _init();
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());

    _playlist = ConcatenatingAudioSource(
      children: widget.files
          .map((file) => AudioSource.uri(
                Uri.parse(file.url),
                tag: AudioMetadata(title: file.title),
              ))
          .toList(),
    );

    // Listen to errors during playback.
    _player.playbackEventStream.listen((event) {}, onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    try {
      await _player.setAudioSource(_playlist, preload: false);
    } catch (e) {
      // Catch load errors: 404, invalid url...
      print("Error loading audio source: $e");
    }
  }

  Stream<PositionData> get _positionDataStream => Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
      _player.positionStream,
      _player.bufferedPositionStream,
      _player.durationStream,
      (position, bufferedPosition, duration) => PositionData(position, bufferedPosition, duration ?? Duration.zero));

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 48.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 2.0,
              sigmaY: 2.0,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: const BorderRadius.all(
                  Radius.circular(12.0),
                ),
                border: Border.all(
                  color: Colors.white,
                  width: 1.0,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreamBuilder<SequenceState?>(
                    stream: _player.sequenceStateStream,
                    builder: (context, snapshot) {
                      final state = snapshot.data;
                      if (state?.sequence.isEmpty ?? true) return const SizedBox();
                      final metadata = state?.currentSource!.tag as AudioMetadata;

                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            metadata.title ?? '',
                            style: TextStyle(fontSize: 10.0),
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(
                    height: 12.0,
                    child: ControlButtons(player: _player),
                  ),
                  SizedBox(
                    height: 20.0,
                    child: StreamBuilder<PositionData>(
                      stream: _positionDataStream,
                      builder: (context, snapshot) {
                        final positionData = snapshot.data;
                        return SeekBar(
                          duration: positionData?.duration ?? Duration.zero,
                          position: positionData?.position ?? Duration.zero,
                          bufferedPosition: positionData?.bufferedPosition ?? Duration.zero,
                          onChangeEnd: (newPosition) {
                            _player.seek(newPosition);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Release the player's resources when not in use. We use "stop" so that
      // if the app resumes later, it will still remember what position to
      // resume from.
      _player.stop();
    }
  }
}

class AudioMetadata {
  final String? album;
  final String? title;
  final String? artwork;

  AudioMetadata({
    this.album,
    this.title,
    this.artwork,
  });
}
