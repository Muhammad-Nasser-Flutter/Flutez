import 'package:flutez/core/helpers/extensions.dart';
import 'package:flutez/core/routing/routes.dart';
import 'package:flutez/core/theming/colors.dart';
import 'package:flutez/core/widgets/custom_button.dart';
import 'package:flutez/core/widgets/custom_text_form_field.dart';
import 'package:flutez/core/widgets/custom_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theming/assets.dart';
import '../../../../core/utilies/easy_loading.dart';
import '../../Bloc/Auth_cubit.dart';
import '../../Bloc/auth_states.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  var emailController = TextEditingController();
  var passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
          child: BlocConsumer<AuthCubit, AuthStates>(
            listener: (context, state) {
              if (state is LoginSuccessState) {
                hideLoading();
                context.pushReplacementNamed(Routes.homeScreen);
              } else if (state is LoginErrorState) {
                hideLoading();
              }
            },
            builder: (context, state) {
              var authCubit = AuthCubit.get(context);
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Center(
                      child: Container(
                        height: 200.h,
                        width: 260.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.r),
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(Assets.logo),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text24(text: "Login to Enjoy Our"),
                    Text28(text: "Music"),
                    SizedBox(
                      height: 40.h,
                    ),
                    CustomTextFormField(
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.white,
                      ),
                      hintText: "Email",
                      controller: emailController,
                      borderWidth: 1,
                      keyboardType: TextInputType.emailAddress,
                      validator: (s) {
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomTextFormField(
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.white,
                      ),
                      hintText: "Password",
                      controller: passController,
                      borderWidth: 1,
                      obscureText: authCubit.isPassword,
                      keyboardType: TextInputType.visiblePassword,
                      suffixIcon: IconButton(
                        icon: Icon(authCubit.suffix),
                        onPressed: () {
                          authCubit.changePasswordVisibility();
                        },
                      ),
                      validator: (s) {
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    CustomButton(
                      width: double.maxFinite,
                      text: "LOGIN",
                      color: AppColors.smallTextColor,
                      onPressed: () {
                        authCubit.login(
                            email: emailController.text,
                            pass: passController.text,
                            context: context);
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text16(
                          text: "Don't have an Account ?  ",
                          textColor: Colors.white,
                        ),
                        InkWell(
                          onTap: () {
                            context.pushReplacementNamed(Routes.registerScreen);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text18(
                              text: "REGISTER",
                              textColor: AppColors.smallTextColor,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          authCubit.signInWithGoogle();
                        },
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.8,
                          padding: EdgeInsets.all(2.r),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              color: Colors.white),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10.r),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.r),
                                    color: Colors.white),
                                child: SvgPicture.asset(
                                  Assets.googleIcon,
                                  width: 35.r,
                                ),
                              ),
                              SizedBox(
                                width: 25.w,
                              ),
                              Text20(
                                text: "Sign in with Google",
                                maxLines: 1,
                                overFlow: TextOverflow.ellipsis,
                                textColor: Colors.black,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          authCubit.facebookLogin(context);
                        },
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.8,
                          padding: EdgeInsets.all(2.r),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            color: const Color(0xFF0866ff),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10.r),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
                                  color: Colors.white,
                                ),
                                child: SvgPicture.asset(
                                  Assets.faceBookIcon,
                                  width: 35.r,
                                ),
                              ),
                              SizedBox(
                                width: 25.w,
                              ),
                              Text20(
                                text: "Sign in with Facebook",
                                maxLines: 1,
                                overFlow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
