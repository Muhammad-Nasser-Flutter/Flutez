import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutez/core/cache_helper/cache_helper.dart';
import 'package:flutez/core/cache_helper/cache_values.dart';
import 'package:flutez/core/functions/flutter_toast.dart';
import 'package:flutez/core/theming/colors.dart';
import 'package:flutez/features/Profile/Models/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());
  static AuthCubit get(context) => BlocProvider.of(context);

  bool checkValidity({
    required String email,
    required String pass,
    required String userName,
    required String phone,
  }) {
    if (email.contains("@") && email.contains(".com")) {
      if (pass.length > 8) {
        if (userName.length > 3) {
          if (phone.length == 11) {
            return true;
          } else {
            customToast(msg: "name is too short", color: Colors.red);
            return false;
          }
        } else {
          customToast(msg: "name is too short", color: Colors.red);
          return false;
        }
      } else {
        customToast(msg: "pass is less than 8 digits", color: Colors.red);
        return false;
      }
    } else {
      customToast(msg: "not valid email", color: Colors.red);
      return false;
    }
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();

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
    ProfileModel userModel = ProfileModel(
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
      customToast(
          msg: "Logged in Successfully", color: AppColors.smallTextColor);
    }).catchError((error) {
      if (email.isNotEmpty) {
        if (pass.isNotEmpty) {
          customToast(msg: "Email or password is invalid", color: Colors.red);
        } else {
          customToast(msg: "password is must not be empty", color: Colors.red);
        }
      } else {
        customToast(msg: "Email must not be empty", color: Colors.red);
      }
      emit(LoginErrorState());
    });
  }

  Future<void> signInWithGoogle() async {
    GoogleSignInAccount? account = await _googleSignIn.signIn();
    if (account != null) {
      GoogleSignInAuthentication authentication = await account.authentication;
      OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: authentication.idToken,
        accessToken: authentication.accessToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential).then(
        (value) async {
          var profile = ProfileModel(
            email: value.user!.email,
            image: value.user!.photoURL,
            name: value.user!.displayName,
            phone: value.user!.phoneNumber,
            uId: value.user!.uid,
          );
          DocumentSnapshot snapshot = await FirebaseFirestore.instance
              .collection("Users")
              .doc(profile.uId)
              .get();
          if (!snapshot.exists) {
            FirebaseFirestore.instance
                .collection("Users")
                .doc(profile.uId)
                .set(profile.toJson());
          }
          CacheHelper.saveData(key: CacheKeys.uId, value: value.user!.uid);
          emit(LoginSuccessState());
        },
      );
    } else {
      emit(LoginErrorState());
    }
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChangePasswordVisibilityState());
  }
}
