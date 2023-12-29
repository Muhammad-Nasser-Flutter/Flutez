import 'package:audio_service/audio_service.dart';
import 'package:flutez/features/Track/Bloc/track_states.dart';
import 'package:flutez/features/Track/Model/track_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../Model/music_player_data.dart';

class SongRepository {
  SongRepository({required AudioHandler audioHandler})
      : _audioHandler = audioHandler;

  // static SongRepository get(context)=> BlocProvider.of(context);
  final AudioHandler _audioHandler;

  void play() => _audioHandler.play();
  void pause() => _audioHandler.pause();
  Stream<MusicPlayerData> get musicPlayerDataStream => Rx.combineLatest4<
              PlaybackState,
              List<MediaItem>,
              MediaItem?,
              Duration,
              MusicPlayerData>(_audioHandler.playbackState, _audioHandler.queue,
          _audioHandler.mediaItem, AudioService.position, (
        PlaybackState playbackState,
        List<MediaItem> queue,
        MediaItem? mediaItem,
        Duration position,
      ) {
        return MusicPlayerData(
            songQueue: queue.map((mediaItem) {
              return Song.fromMediaItem(mediaItem);
            }).toList(),
            playbackState: playbackState,
            currentTrack:
                (mediaItem == null) ? null : Song.fromMediaItem(mediaItem),
            currentSongDuration:
                (mediaItem == null) ? null : mediaItem.duration,
          currentSongPosition: position,
        );
      });

  Future<void> setCurrentSong(Song song)async{
    _audioHandler.removeQueueItemAt(0);
    _audioHandler.addQueueItem(song.toMediaItem());
  }
}
