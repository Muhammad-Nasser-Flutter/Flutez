import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutez/core/helpers/extensions.dart';
import 'package:flutez/core/routing/routes.dart';
import 'package:flutez/core/theming/assets.dart';
import 'package:flutez/core/theming/colors.dart';
import 'package:flutez/core/widgets/custom_texts.dart';
import 'package:flutez/core/widgets/icon_widget.dart';
import 'package:flutez/features/Profile/Bloc/profile_cubit.dart';
import 'package:flutez/features/Profile/Bloc/profile_states.dart';
import 'package:flutez/features/Track/presentation/Shimmers/image_shimmer.dart';
import 'package:flutez/features/home/presentation/widgets/drawer/LogoutCubit/states.dart';
import 'package:flutez/features/home/presentation/widgets/drawer/drawer_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'LogoutCubit/cubit.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileStates>(
      builder: (context, state) {
        var profileCubit = ProfileCubit.get(context);
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
                  Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          width: 140.r,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          height: 140.r,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: profileCubit.user != null
                              ? CachedNetworkImage(
                                  placeholder: (context, object) {
                                    return const ImageShimmer(
                                      width: double.maxFinite,
                                      height: double.maxFinite,
                                    );
                                  },
                                  imageUrl: profileCubit.user!.image!,
                                  fit: BoxFit.cover,
                                )
                              : const ImageShimmer(
                                  width: double.maxFinite,
                                  height: double.maxFinite,
                                ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: SvgPicture.asset(Assets.editImageIcon),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text26(
                          text: "Hello ${profileCubit.user?.name}",
                          overFlow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      SvgPicture.asset(
                        Assets.handShakeIcon,
                        width: 40.r,
                      )
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
