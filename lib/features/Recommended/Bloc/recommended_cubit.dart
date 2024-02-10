import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutez/features/Recommended/Bloc/recommended_states.dart';
import 'package:flutez/features/Track/Model/track_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecommendedCubit extends Cubit<RecommendedStates> {
  RecommendedCubit() : super(RecommendedInitialState());
  static RecommendedCubit get(context) => BlocProvider.of(context);

  List<Track> recommendedTracks = [];
  Future<void> getRecommendedTracks() async {
    FirebaseFirestore.instance.collection("AllTracks").get().then((value) {
      List<QueryDocumentSnapshot> x = value.docs;
      x.shuffle();
      recommendedTracks = [];
      for (int i = 0; i < 10; i++) {
        recommendedTracks
            .add(Track.fromJson(x[i].data() as Map<String, dynamic>));
      }
      emit(GetRecommendedSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetRecommendedErrorState());
    });
  }
}
