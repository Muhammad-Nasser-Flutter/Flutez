import 'package:audio_service/audio_service.dart';
import 'package:flutez/features/Track/Bloc/track_states.dart';
import 'package:flutez/features/Track/Model/track_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../packages/audio_handler/lib/src/audio_handler.dart';
import '../Model/music_player_data.dart';

class TrackCubit extends Cubit<TrackStates>{
  TrackCubit():super(TrackInitialState());
  static TrackCubit get (context)=> BlocProvider.of(context);


  // static SongRepository get(context)=> BlocProvider.of(context);
  AudioHandler? audioHandler;
  void initHandler()async{
    audioHandler = await AudioService.init(
      builder: () => MyAudioHandler(),
      config: const AudioServiceConfig(
        // androidNotificationChannelId: "com.example.Flutez",
        // androidNotificationChannelName: "Flutez",
        // androidNotificationOngoing: true,
        // androidStopForegroundOnPause: true,
      ),
    );
  }
  void play() => audioHandler!.play();
  void pause() => audioHandler!.pause();
  Stream<MusicPlayerData> get musicPlayerDataStream => Rx.combineLatest4<
              PlaybackState,
              List<MediaItem>,
              MediaItem?,
              Duration,
              MusicPlayerData>(audioHandler!.playbackState, audioHandler!.queue,
          audioHandler!.mediaItem, AudioService.position, (
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
    audioHandler!.removeQueueItemAt(0);
    audioHandler!.addQueueItem(song.toMediaItem());
  }
}
