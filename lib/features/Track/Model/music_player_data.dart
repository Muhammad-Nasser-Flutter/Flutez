import 'package:audio_service/audio_service.dart';
import 'package:flutez/features/Track/Model/track_model.dart';

class MusicPlayerData {
  final Song? currentTrack;
  final List<Song> songQueue;
  final PlaybackState playbackState;
  final Duration? currentSongDuration;
  final Duration? currentSongPosition;

  MusicPlayerData({
    this.currentTrack,
    required this.songQueue,
    required this.playbackState,
    this.currentSongDuration,
    this.currentSongPosition,
  });
}
