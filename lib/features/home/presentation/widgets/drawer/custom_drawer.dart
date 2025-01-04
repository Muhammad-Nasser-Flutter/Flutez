import 'package:flutez/core/helpers/extensions.dart';
import 'package:flutez/core/routing/routes.dart';
import 'package:flutez/core/theming/assets.dart';
import 'package:flutez/core/theming/colors.dart';
import 'package:flutez/core/widgets/icon_widget.dart';
import 'package:flutez/features/Profile/Bloc/profile_cubit.dart';
import 'package:flutez/features/Profile/Bloc/profile_states.dart';
import 'package:flutez/features/home/presentation/widgets/drawer/LogoutCubit/states.dart';
import 'package:flutez/features/home/presentation/widgets/drawer/drawer_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'LogoutCubit/cubit.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileStates>(
      builder: (context, state) {
        return Drawer(
          width: MediaQuery.sizeOf(context).width * 0.68,
          backgroundColor: AppColors.scaffoldBackground,
          shape: const ContinuousRectangleBorder(),
          key: _key,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconWidget(
                        onPressed: () {
                          context.pop();
                        },
                        iconAsset: Assets.exitIcon,
                        size: 20.r,
                      ),
                      IconWidget(
                        onPressed: () {},
                        iconAsset: Assets.moonIcon,
                        size: 20.r,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  DrawerItem(
                    icon: Assets.heartIcon,
                    label: "Liked Songs",
                    onPressed: () {
                      // context.pop();
                      context.pushNamed(Routes.likedSongs);
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  DrawerItem(
                    icon: Assets.downloadIcon,
                    label: "Downloads",
                    onPressed: () {
                      // context.pop();
                      context.pushNamed(Routes.downloadsScreen);
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  DrawerItem(
                    icon: Assets.languageIcon,
                    label: "Language",
                    onPressed: () {},
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  DrawerItem(
                    icon: Assets.contactUsIcon,
                    label: "Contact us",
                    onPressed: () {},
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  DrawerItem(
                    icon: Assets.fAQIcon,
                    label: "FAQs",
                    onPressed: () {},
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  DrawerItem(
                    icon: Assets.settingsIcon,
                    label: "Settings",
                    onPressed: () {},
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  BlocProvider(
                    create: (context) => LogoutCubit(),
                    child: BlocConsumer<LogoutCubit, LogoutStates>(
                      listener: (context, state) {
                        if (state is LogoutSuccessState) {
                          context.pushNamedAndRemoveUntil(
                            Routes.loginScreen,
                            (route) => false,
                            predicate: (route) => false,
                          );
                        }
                      },
                      builder: (context, state) {
                        var logoutCubit = LogoutCubit.get(context);
                        return DrawerItem(
                          icon: Assets.logoutIcon,
                          label: "Logout",
                          onPressed: () {
                            logoutCubit.logout(context: context);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
