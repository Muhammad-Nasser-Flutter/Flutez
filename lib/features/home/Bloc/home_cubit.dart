import 'dart:convert';

import 'package:flutez/core/theming/assets.dart';
import 'package:flutez/core/theming/colors.dart';
import 'package:flutez/features/home/Bloc/home_states.dart';
import 'package:flutez/features/home/models/recommended_track_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:http/http.dart' as http;

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());
  static HomeCubit get(context) => BlocProvider.of(context);

  PaletteGenerator? _paletteGenerator;

  List recommendedShadows =[];

  List playlistShadows =
      List.generate(10, (index) => AppColors.scaffoldBackground);

  Future<void> updateRecommendedPaletteGenerator() async {
    // Replace 'your_image_path.jpg' with the actual path to your image
    recommendedShadows = List.generate(recommendedTracks.length, (index) => AppColors.scaffoldBackground);
    for (int i = 0; i < recommendedTracks.length; i++) {
      var imageProvider = NetworkImage(recommendedTracks[i].thumbnail);
      PaletteGenerator paletteGenerator =
          await PaletteGenerator.fromImageProvider(imageProvider);

      _paletteGenerator = paletteGenerator;
      recommendedShadows[i] =
          _paletteGenerator?.vibrantColor?.color.withOpacity(0.1);
    }
    print(recommendedShadows.toString());
    emit(RecommendedShadowsSuccessState());
  }

  Future<void> updatePlaylistPaletteGenerator() async {
    // Replace 'your_image_path.jpg' with the actual path to your image
    const imageProvider = AssetImage(Assets.cover3);

    for (int i = 0; i < 10; i++) {
      PaletteGenerator paletteGenerator =
          await PaletteGenerator.fromImageProvider(imageProvider);

      _paletteGenerator = paletteGenerator;
      playlistShadows[i] =
          _paletteGenerator?.vibrantColor?.color.withOpacity(0.1);
    }
  }

  Uri recommendedTracksUri() {
    return Uri.parse(
        "https://youtube-music-api3.p.rapidapi.com/recommend?gl=US");
  }

  List recommendedTracks = [];
  Future<void> getRecommendedTracks() async {
    try {
      var response = await http.get(
        recommendedTracksUri(),
        headers: {
          'X-RapidAPI-Key':
              '2d8243ce2dmsh4e144f95478f00fp113780jsna2a7b17243c6',
          'X-RapidAPI-Host': 'youtube-music-api3.p.rapidapi.com'
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        recommendedTracks = jsonResponse["results"]
            .map((model) => RecommendedTrackModel.fromJson(model))
            .toList()
            .take(10)
            .toList();
        updateRecommendedPaletteGenerator();
        emit(GetRecommendedSuccessState());
      } else {
        debugPrint("no tracks available");
        emit(GetRecommendedErrorState());
      }
    } catch (err) {
      debugPrint(err.toString());
      emit(GetRecommendedErrorState());
    }
  }
}
