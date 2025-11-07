
import 'package:audio_service/audio_service.dart';
import 'package:flutez/core/functions/flutter_toast.dart';
import 'package:flutez/core/theming/colors.dart';
import 'package:flutez/features/Downloads/models/downloaded_track_model.dart';
import 'package:flutez/features/Track/Bloc/track_states.dart';
import 'package:flutez/features/Track/Model/position_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../core/theming/assets.dart';
import '../Model/track_model.dart';

class TrackCubit extends Cubit<TrackStates> {
  TrackCubit() : super(TrackInitialState());
  static TrackCubit get(context) => BlocProvider.of(context);

  AudioPlayer? audioPlayer;
  bool isOffline = false;

  void handleOnlinePlaylist(List<Track> playlist, int index) async {
    isOffline = false;
    List<AudioSource> list = playlist
        .map(
          (e) => AudioSource.uri(
            Uri.parse(e.trackLink!),
            tag: MediaItem(
              title: e.trackName.toString(),
              artist: e.artist.toString(),
              artUri: Uri.parse(e.image.toString()),
              album: e.trackLink,
              id: e.trackLink.toString(),
            ),
          ),
        )
        .toList();
    audioPlayer = AudioPlayer();
    await audioPlayer?.setAudioSource(
      ConcatenatingAudioSource(children: list),
    );
    await audioPlayer?.seek(Duration.zero, index: index);
    await audioPlayer?.play();
    await audioPlayer?.setLoopMode(LoopMode.all);
  }

  void handleOfflinePlaylist(List<DownloadedTrackModel> playlist, int index) async {
    isOffline = true;
    // to make the chosen track the first item played
    // Track item = test.tracks!.removeAt(index);
    // test.tracks!.insert(0, item);
    // adding them to the playlist
    List<AudioSource> list = playlist
        .map(
          (e) => AudioSource.file(
            e.localPath,
            tag: MediaItem(
              title: e.title.toString(),
              artist: e.artist.toString(),
              artUri: Uri.file(e.localImagePath),
              album: e.localImagePath,
              id: e.localPath.toString(),
            ),
          ),
        )
        .toList();
    audioPlayer = AudioPlayer();
    await audioPlayer?.setAudioSource(ConcatenatingAudioSource(children: list), initialIndex: index);
    // await audioPlayer?.seek(Duration.zero, index: index);
    await audioPlayer?.play();
    await audioPlayer?.setLoopMode(LoopMode.all);
  }

  void play() => audioPlayer!.play();
  void pause() => audioPlayer!.pause();

  Stream<PositionData> get positionDataStream =>
      Rx.combineLatest5<Duration, Duration, Duration?, PlayerState, SequenceState?, PositionData>(
        audioPlayer!.positionStream,
        audioPlayer!.bufferedPositionStream,
        audioPlayer!.durationStream,
        audioPlayer!.playerStateStream,
        audioPlayer!.sequenceStateStream,
        (position, bufferedPosition, duration, playerState, sequenceState) => PositionData(
          position,
          bufferedPosition,
          duration ?? Duration.zero,
          playerState,
          sequenceState,
        ),
      );

  void changeVolume(double d) {
    audioPlayer!.setVolume(d);
    emit(SetVolumeState());
  }

  Track? currentTrack;
  void setCurrentTrack({
    required List<dynamic> playlist,
    required int index,
    bool isOffline = false,
  }) {
    if (isOffline) {
      if (currentTrack?.trackLink != playlist[index].localPath) {
        if (currentTrack != null) {
          removeCurrentTrack();
        }
        currentTrack = Track(
          trackName: playlist[index].title,
          artist: playlist[index].artist,
          image: playlist[index].localImagePath,
          trackLink: playlist[index].localPath,
        );
        handleOfflinePlaylist(
          playlist as List<DownloadedTrackModel>,
          index,
        );
      }
    } else {
      if (currentTrack?.trackLink != playlist[index].trackLink) {
        if (currentTrack != null) {
          removeCurrentTrack();
        }
        currentTrack = playlist[index];
        handleOnlinePlaylist(
          playlist as List<Track>,
          index,
        );
      }
    }

    emit(SetTrackState());
  }

  void removeCurrentTrack() {
    currentTrack = null;
    audioPlayer!.stop();
  }

  void seekToNextTrack() {
    audioPlayer?.seekToNext();
    emit(SeekToNextState());
  }

  void seekToPrevTrack() {
    audioPlayer?.seekToPrevious();
    emit(SeekToPrevState());
  }

  void changeLoopMode() {
    switch (audioPlayer?.loopMode.name) {
      case "all":
        audioPlayer?.setLoopMode(LoopMode.one);
        customToast(msg: "Loop current track enabled", color: AppColors.smallTextColor);
      case "one":
        audioPlayer?.setLoopMode(LoopMode.off);
        customToast(msg: "Loop off", color: AppColors.smallTextColor);
      case "off":
        audioPlayer?.setLoopMode(LoopMode.all);
        customToast(msg: "Loop all enabled", color: AppColors.smallTextColor);
    }
    emit(ChangeLoopModeState());
  }

  void mute() {
    if (audioPlayer!.volume != 0) {
      audioPlayer!.setVolume(0);
      customToast(msg: "Muted", color: AppColors.smallTextColor);
    } else {
      audioPlayer!.setVolume(1);
    }
  }

  void changeShuffleMode() {
    if (audioPlayer!.shuffleModeEnabled) {
      audioPlayer?.setShuffleModeEnabled(false);
      customToast(msg: "Shuffle mode off", color: AppColors.smallTextColor);
    } else {
      audioPlayer?.setShuffleModeEnabled(true);
      customToast(msg: "Shuffle mode on", color: AppColors.smallTextColor);
    }
  }

  String loopIcon() {
    switch (audioPlayer?.loopMode.name) {
      case "all":
        return Assets.repeatIcon;
      case "one":
        return Assets.repeatCurrentSongIcon;
      default:
        return Assets.repeatOffIcon;
    }
  }

  String volumeIcon() {
    switch (audioPlayer?.volume) {
      case == 0:
        return Assets.muteIcon;
      default:
        return Assets.volumeIcon;
    }
  }
}
