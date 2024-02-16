import 'package:audio_service/audio_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutez/core/functions/flutter_toast.dart';
import 'package:flutez/core/theming/colors.dart';
import 'package:flutez/features/Track/Bloc/track_states.dart';
import 'package:flutez/features/Track/Model/position_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../core/theming/assets.dart';
import '../../Playlists/models/playlist_model.dart';
import '../Model/track_model.dart';

class TrackCubit extends Cubit<TrackStates> {
  TrackCubit() : super(TrackInitialState());
  static TrackCubit get(context) => BlocProvider.of(context);

  AudioPlayer? audioPlayer;
  List<AudioSource> list = [];

  void initHandler(Track track, PlaylistModel playlist, int index) async {
    list = [];
    // to make the chosen track the first item played
    PlaylistModel test = PlaylistModel.fromJson(playlist.toJson());
    Track item = test.tracks!.removeAt(index);
    test.tracks!.insert(0, item);
    // adding them to the playlist
    for (var element in test.tracks!) {
      list.add(
        AudioSource.uri(
          Uri.parse(element.trackLink!),
          tag: MediaItem(
            title: element.trackName.toString(),
            artist: element.artist.toString(),
            artUri: Uri.parse(element.image.toString()),
            album: element.trackLink,
            id: element.trackLink.toString(),
          ),
        ),
      );
    }
    audioPlayer = AudioPlayer()
      ..setAudioSource(
        ConcatenatingAudioSource(children: list),
      )
      ..play()
      ..setLoopMode(LoopMode.all);
    emit(InitAudioHandlerSuccessState());
  }

  void play() => audioPlayer!.play();
  void pause() => audioPlayer!.pause();

  Stream<PositionData> get positionDataStream => Rx.combineLatest5<Duration,
          Duration, Duration?, PlayerState, SequenceState?, PositionData>(
        audioPlayer!.positionStream,
        audioPlayer!.bufferedPositionStream,
        audioPlayer!.durationStream,
        audioPlayer!.playerStateStream,
        audioPlayer!.sequenceStateStream,
        (position, bufferedPosition, duration, playerState, sequenceState) =>
            PositionData(
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
    required String trackImgUrl,
    required String trackUrl,
    required String title,
    required String author,
    required PlaylistModel playlist,
    required int index,
  }) {
    if (currentTrack?.trackLink != trackUrl) {
      if (currentTrack != null) {
        removeCurrentTrack();
      }
      currentTrack = Track(
        artist: author,
        trackName: title,
        image: trackImgUrl,
        trackLink: trackUrl,
      );
      initHandler(currentTrack!, playlist, index);
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
    if(audioPlayer!.volume!=0){
      audioPlayer!.setVolume(0);
      customToast(msg: "Muted", color: AppColors.smallTextColor);
    }else{
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
