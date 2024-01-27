import 'package:flutez/core/helpers/extensions.dart';
import 'package:flutez/core/routing/routes.dart';
import 'package:flutez/core/theming/colors.dart';
import 'package:flutez/core/widgets/custom_button.dart';
import 'package:flutez/core/widgets/custom_text_form_field.dart';
import 'package:flutez/core/widgets/custom_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/assets.dart';
import '../../Bloc/Auth_cubit.dart';
import '../../Bloc/auth_states.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  var emailController = TextEditingController();
  var passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
          child: BlocConsumer<AuthCubit, AuthStates>(
            listener: (context,state){
              if(state is LoginSuccessState){
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
                      validator: (s) {},
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
                      validator: (s) {},
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    CustomButton(
                      text: "LOGIN",
                      color: AppColors.smallTextColor,
                      onPressed: () {
                        authCubit.login(email: emailController.text, pass: passController.text,  context: context);
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
