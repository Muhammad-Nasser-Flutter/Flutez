import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutez/core/cache_helper/cache_helper.dart';
import 'package:flutez/core/cache_helper/cache_values.dart';
import 'package:flutez/features/Profile/Bloc/profile_states.dart';
import 'package:flutez/features/Profile/Models/profile_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitialState());
  static ProfileCubit get(context) => BlocProvider.of(context);
  ProfileModel? user;
  Future<void> getProfileData() async {
    String uId = CacheHelper.getData(key: CacheKeys.uId);
    FirebaseFirestore.instance
        .collection("Users")
        .doc(uId)
        .snapshots()
        .listen((event) {
          user = ProfileModel.fromJson(event.data()!);
          emit(GetProfileDataSuccessState());
    }).onError((error){
      if (kDebugMode) {
        print(error.toString());
      }
      emit(GetProfileDataErrorState());
    });
  }
}
