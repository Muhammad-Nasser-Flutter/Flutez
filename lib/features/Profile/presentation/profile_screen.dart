import 'package:flutez/core/helpers/extensions.dart';
import 'package:flutez/core/theming/assets.dart';
import 'package:flutez/core/theming/colors.dart';
import 'package:flutez/core/widgets/icon_widget.dart';
import 'package:flutez/features/Profile/presentation/widgets/profile_widget.dart';
import 'package:flutez/features/home/presentation/widgets/drawer/drawer_item.dart';
import 'package:flutez/features/Track/presentation/widgets/playingTrack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../Track/Bloc/track_cubit.dart';
import '../../Track/Bloc/track_states.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconWidget(
              onPressed: () {
                context.pop();
              },
              iconAsset: Assets.arrowBackIcon,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
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
                    child: Image.asset(
                      Assets.cover1,
                      fit: BoxFit.cover,
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
            ProfileWidget(
                icon: Assets.editProfileIcon,
                label: "User Name",
                onPressed: () {}),
            SizedBox(
              height: 20.h,
            ),
            ProfileWidget(
                icon: Assets.mailIcon, label: "Email", onPressed: () {}),
            SizedBox(
              height: 20.h,
            ),
            ProfileWidget(
                icon: Assets.settingsIcon, label: "Settings", onPressed: () {}),
            SizedBox(
              height: 20.h,
            ),
            ProfileWidget(
                icon: Assets.logoutIcon, label: "Logout", onPressed: () {}),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
      bottomNavigationBar:const PlayingTrack(),

    );
  }
}
