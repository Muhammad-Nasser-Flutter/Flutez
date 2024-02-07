import 'package:audio_service/audio_service.dart';
import 'package:flutez/features/Track/Bloc/track_states.dart';
import 'package:flutez/features/Track/Model/position_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import '../../Playlists/models/playlist_model.dart';
import '../Model/track_model.dart';

class TrackCubit extends Cubit<TrackStates> {
  TrackCubit() : super(TrackInitialState());
  static TrackCubit get(context) => BlocProvider.of(context);

  AudioPlayer? audioPlayer;
  List<AudioSource> list = [];

  void initHandler(Track track, PlaylistModel playlist,int index) async {
    list = [];
    // to make the chosen track the first item played
    PlaylistModel test = playlist;
    Track item = test.tracks!.removeAt(index);
    test.tracks!.insert(0, item);
    // adding them to the playlist
    for (var element in test.tracks!) {
      list.add(
        AudioSource.uri(
          Uri.parse(element.trackLink!),
          tag: MediaItem(
            id: element.id.toString(),
            title: element.trackName.toString(),
            artist: element.artist.toString(),
            artUri: Uri.parse(element.image.toString()),
            album: element.trackLink,
          ),
        ),
      );
    }
    audioPlayer = AudioPlayer()
      ..setAudioSource(
        ConcatenatingAudioSource(children: list),
      )..play();
    emit(InitAudioHandlerSuccessState());
  }

  void play() => audioPlayer!.play();
  void pause() => audioPlayer!.pause();

  Stream<PositionData> get positionDataStream => Rx.combineLatest5<Duration,
          Duration, Duration?, PlayerState,SequenceState? ,PositionData>(
        audioPlayer!.positionStream,
        audioPlayer!.bufferedPositionStream,
        audioPlayer!.durationStream,
        audioPlayer!.playerStateStream,
        audioPlayer!.sequenceStateStream,
        (position, bufferedPosition, duration, playerState,sequenceState) => PositionData(
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
    required String shadowColor,
    required String title,
    required String author,
    required int id,
    required playlist,
    required int index,
  }) {
    if (currentTrack?.trackLink != trackUrl) {
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
      initHandler(currentTrack!, playlist,index);
    }
    emit(SetTrackState());
  }

  void removeCurrentTrack() {
    currentTrack = null;
    audioPlayer!.stop();
  }

  void seekToNextTrack() async {
    audioPlayer?.seekToNext();
    emit(SetTrackState());
  }

  void seekToPrevTrack()  {
    audioPlayer?.seekToPrevious();
    emit(SetTrackState());
  }
}
