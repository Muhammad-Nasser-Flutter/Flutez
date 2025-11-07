import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutez/features/Search/Bloc/search_states.dart';
import 'package:flutez/features/Track/Model/track_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());
  static SearchCubit get(context) => BlocProvider.of(context);

  void searchTracks({required String text}) {
    FirebaseFirestore.instance.collection("AllTracks").snapshots().listen((value) {
      List<Track> searches = [];
      for (var element in value.docs) {
        if (element.data()["trackName"].toUpperCase().contains(text.toUpperCase()) ||
            element.data()["artist"].toUpperCase().contains(text.toUpperCase())) {
          searches.add(Track.fromJson(element.data()));
        }
      }
      emit(SearchSuccessState(searches));
    }).onError((error) {
      debugPrint(error.toString());
      emit(SearchErrorState());
    });
  }

  void getAllTracks() {
    FirebaseFirestore.instance.collection("AllTracks").snapshots().listen((value) {
      emit(SearchSuccessState(value.docs.map((e) => Track.fromJson(e.data())).toList()));
    }).onError((error) {
      debugPrint(error.toString());
      emit(SearchErrorState());
    });
  }
}
