import 'package:audio_service/audio_service.dart';
import 'package:flutez/features/Track/Bloc/track_states.dart';
import 'package:flutez/features/Track/Model/position_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import '../../home/models/playlist_model.dart';

class TrackCubit extends Cubit<TrackStates> {
  TrackCubit() : super(TrackInitialState());
  static TrackCubit get(context) => BlocProvider.of(context);

  AudioPlayer? audioPlayer;

  void initHandler(Track track) async {
    audioPlayer = AudioPlayer()
      ..setAudioSource(
        AudioSource.uri(
          Uri.parse(track.trackLink!),
          tag: MediaItem(
            id: track.id.toString(),
            title: track.trackName!,
            artist: track.artist!,
            artUri: Uri.parse(track.image!),
          ),
        ),
      );
    emit(InitAudioHandlerSuccessState());
  }

  void play() => audioPlayer!.play();
  void pause() => audioPlayer!.pause();

  Stream<PositionData> get positionDataStream => Rx.combineLatest4<Duration,
          Duration, Duration?, PlayerState, PositionData>(
        audioPlayer!.positionStream,
        audioPlayer!.bufferedPositionStream,
        audioPlayer!.durationStream,
        audioPlayer!.playerStateStream,
        (position, bufferedPosition, duration, playerState) => PositionData(
          position,
          bufferedPosition,
          duration ?? Duration.zero,
          playerState,
        ),
      );

  void changeVolume(double d){
    audioPlayer!.setVolume(d);
    emit(SetVolumeState());
  }

  Track? currentTrack;
  void setCurrentTrack({
    required String trackImgUrl,
    required String trackUrl,
    required String shadowColor,
    required String title,
    required String author,
    required int id,
  }) {
    if(currentTrack?.trackLink != trackUrl ){
      if (currentTrack != null) {
        removeCurrentTrack();
      }
      currentTrack = Track(
        id: id,
        artist: author,
        trackName: title,
        image: trackImgUrl,
        trackLink: trackUrl,
        shadowColor: shadowColor,
      );

      initHandler(currentTrack!);
      play();
    }else{
      print(2);
    }
    emit(SetTrackState());
  }

  void removeCurrentTrack() {
    currentTrack = null;
    audioPlayer!.stop();
  }

  // Color? playingNowShadow;
  // Future<void> updatePlayingPaletteGenerator() async {
  //   // Replace 'your_image_path.jpg' with the actual path to your image
  //   if (currentTrack != null) {
  //     var imageProvider = NetworkImage(currentTrack!.image!);
  //     PaletteGenerator paletteGenerator =
  //         await PaletteGenerator.fromImageProvider(imageProvider);
  //
  //     _paletteGenerator = paletteGenerator;
  //     playingNowShadow =
  //         _paletteGenerator?.vibrantColor?.color.withOpacity(0.1);
  //   }
  //
  //   emit(ShadowsSuccessState());
  // }
}
