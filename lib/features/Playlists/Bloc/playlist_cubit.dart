import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutez/features/Playlists/Bloc/playlist_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/playlist_model.dart';

class PlaylistCubit extends Cubit<PlaylistStates>{
  PlaylistCubit():super(PlaylistInitialState());
  static PlaylistCubit get(context) => BlocProvider.of(context);

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