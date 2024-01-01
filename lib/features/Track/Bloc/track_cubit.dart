import 'dart:convert';

import 'package:flutez/core/theming/assets.dart';
import 'package:flutez/core/theming/colors.dart';
import 'package:flutez/features/Track/Bloc/track_states.dart';
import 'package:flutez/features/Track/Model/position_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

class TrackCubit extends Cubit<TrackStates> {
  TrackCubit() : super(TrackInitialState());
  static TrackCubit get(context) => BlocProvider.of(context);

  AudioPlayer? audioPlayer;
  void initHandler(String link) async {
    audioPlayer = AudioPlayer()..setUrl(link);
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

  PaletteGenerator? _paletteGenerator;
  List shadows = List.generate(8, (index) => AppColors.scaffoldBackground);

  Future<void> updatePaletteGenerator() async {
    // Replace 'your_image_path.jpg' with the actual path to your image
    const imageProvider = AssetImage(Assets.cover1);
    for (int i = 0; i < 8; i++) {
      PaletteGenerator paletteGenerator =
          await PaletteGenerator.fromImageProvider(imageProvider);

      _paletteGenerator = paletteGenerator;
      shadows[i] = _paletteGenerator!.vibrantColor!.color.withOpacity(0.1);
    }
    emit(ShadowsSuccessState());
  }

  Uri trackLinkUri(String text) {
    return Uri.parse(
        "https://youtube-mp3-downloader2.p.rapidapi.com/ytmp3/ytmp3/?url=https://www.youtube.com/watch?v=$text");
  }

  Future<void> getTrackLink(String text) async {
    emit(GetTrackLinkLoadingState());
    try {
      var response = await http.get(
        trackLinkUri(text),
        headers: {
          'X-RapidAPI-Key':
              '2d8243ce2dmsh4e144f95478f00fp113780jsna2a7b17243c6',
          'X-RapidAPI-Host': 'youtube-mp3-downloader2.p.rapidapi.com'
        },
      );
      if (response.statusCode == 200) {
        audioPlayer!.stop();
        dynamic jsonResponse = jsonDecode(response.body);
        audioPlayer!.setUrl(jsonResponse["link"]);
        play();
        emit(GetTrackLinkSuccessState());
      } else {
        debugPrint("${response.statusCode}");
        emit(GetTrackLinkErrorState());
      }
    } catch (err) {
      debugPrint(err.toString());
      emit(GetTrackLinkErrorState());
    }
  }
}
