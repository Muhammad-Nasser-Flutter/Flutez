import 'package:flutez/core/helpers/extensions.dart';
import 'package:flutez/features/Auth/Bloc/auth_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theming/assets.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/custom_texts.dart';
import '../../Bloc/Auth_cubit.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  var emailController = TextEditingController();
  var passController = TextEditingController();
  var userNameController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
          child: BlocConsumer<AuthCubit, AuthStates>(
            listener: (context, state) {
              if (state is RegisterSuccessState) {
                context.pushReplacementNamed(Routes.homeScreen);
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
                    Text24(text: "Register to Enjoy Our"),
                    Text28(text: "Music"),
                    SizedBox(
                      height: 30.h,
                    ),
                    CustomTextFormField(
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      hintText: "User Name",
                      controller: userNameController,
                      borderWidth: 1,
                      keyboardType: TextInputType.name,
                      validator: (s) {
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20.h,
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
                      obscureText: authCubit.isPassword,
                      borderWidth: 1,
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
                      height: 20.h,
                    ),
                    CustomTextFormField(
                      prefixIcon: const Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                      hintText: "Phone",
                      controller: phoneController,
                      borderWidth: 1,
                      keyboardType: TextInputType.phone,
                      validator: (s) {
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Center(
                      child: CustomButton(
                        width: double.maxFinite,
                        text: "REGISTER",
                        color: AppColors.smallTextColor,
                        onPressed: () {
                          if (authCubit.checkValidity(
                            email: emailController.text,
                            pass: passController.text,
                            userName: userNameController.text,
                            phone:phoneController.text
                          )) {
                            authCubit.register(
                              email: emailController.text,
                              pass: passController.text,
                              userName: userNameController.text,
                              phone: phoneController.text,
                              context: context,
                            );
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text16(
                          text: "Already have an Account ?  ",
                          textColor: Colors.white,
                        ),
                        InkWell(
                          onTap: () {
                            context.pushNamed(Routes.loginScreen);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text18(
                              text: "LOGIN",
                              textColor: AppColors.smallTextColor,
                            ),
                          ),
                        )
                      ],
                    ),
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
