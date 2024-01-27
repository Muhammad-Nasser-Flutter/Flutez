import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutez/core/cache_helper/cache_helper.dart';
import 'package:flutez/core/cache_helper/cache_values.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/user_model.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());
  static AuthCubit get(context) => BlocProvider.of(context);

  void register({
    required String email,
    required String pass,
    required String userName,
    required String phone,
    required context,
  }) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: pass,
    )
        .then((value) {
      createUser(
        email: email,
        pass: pass,
        uId: value.user!.uid,
        phone: phone,
        userName: userName,
        context: context,
      );
      CacheHelper.saveData(key: CacheKeys.uId, value: value.user!.uid);
    }).catchError((error) {
      emit(RegisterErrorState());
    });
  }

  void createUser({
    required String email,
    required String pass,
    required String uId,
    required String phone,
    required String userName,
    required context,
  }) {
    UserModel userModel = UserModel(
      name: userName,
      email: email,
      image: '',
      uId: uId,
      phone: phone,
    );
    FirebaseFirestore.instance
        .collection("Users")
        .doc(uId)
        .set(userModel.toJson())
        .then((value) {
      emit(RegisterSuccessState());
    }).catchError((error) {
      emit(RegisterErrorState());
    });
  }


  void login({
    required String email,
    required String pass,
    required String userName,
    required String phone,
    required context,
  }) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: pass,
    )
        .then((value) {
      CacheHelper.saveData(key: CacheKeys.uId, value: value.user!.uid);
      emit(LoginSuccessState());
    }).catchError((error) {
      emit(LoginErrorState());
    });
  }
  IconData suffix=Icons.visibility_off_outlined;
  bool isPassword = true;
  void changePasswordVisibility(){
    isPassword=!isPassword;
    suffix= isPassword?Icons.visibility_off_outlined:Icons.visibility_outlined;
    emit(ChangePasswordVisibilityState());
  }

}
