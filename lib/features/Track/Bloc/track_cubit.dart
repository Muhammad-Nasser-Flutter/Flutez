import 'package:flutez/features/Track/Bloc/track_states.dart';
import 'package:flutez/features/Track/Model/position_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';


class TrackCubit extends Cubit<TrackStates>{
  TrackCubit():super(TrackInitialState());
  static TrackCubit get (context)=> BlocProvider.of(context);


  AudioPlayer? audioPlayer;
  void initHandler(String link)async{
    audioPlayer = AudioPlayer()..setUrl(link);
    emit(InitAudioHandlerSuccessState());
  }
  void play() => audioPlayer!.play();
  void pause() => audioPlayer!.pause();
  Stream<PositionData> get positionDataStream =>
      Rx.combineLatest4<Duration, Duration, Duration?,PlayerState, PositionData>(
        audioPlayer!.positionStream,
        audioPlayer!.bufferedPositionStream,
        audioPlayer!.durationStream,
        audioPlayer!.playerStateStream,
            (position, bufferedPosition, duration,playerState) => PositionData(
          position,
          bufferedPosition,
          duration ?? Duration.zero,
          playerState,
        ),
      );
}
