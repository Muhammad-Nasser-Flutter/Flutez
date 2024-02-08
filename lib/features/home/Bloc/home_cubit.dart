import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutez/core/theming/colors.dart';
import 'package:flutez/features/home/Bloc/home_states.dart';
import 'package:flutez/features/Playlists/models/playlist_model.dart';
import 'package:flutez/features/home/models/recommended_track_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());
  static HomeCubit get(context) => BlocProvider.of(context);


  List recommendedShadows = [];

  List playlistShadows =
      List.generate(10, (index) => AppColors.scaffoldBackground);


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
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        recommendedTracks = jsonResponse["results"]
            .map((model) => RecommendedTrackModel.fromJson(model))
            .toList()
            .take(10)
            .toList();
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

  List playlists = [];

  Future<void> getPlaylist() async {
    FirebaseFirestore.instance.collection("Playlists").snapshots().listen((event) {
      playlists = [];
      for (var element in event.docs) {
        playlists.add(PlaylistModel.fromJson(element.data()));
      }
      emit(GetPlaylistsSuccessState());
    });

  }
}
