import 'package:flutez/core/theming/assets.dart';
import 'package:flutez/core/widgets/custom_texts.dart';
import 'package:flutez/core/widgets/search_icon.dart';
import 'package:flutez/features/home/presentation/widgets/my_playlist_widget.dart';
import 'package:flutez/features/home/presentation/widgets/playingTrack.dart';
import 'package:flutez/features/home/presentation/widgets/recommended_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(10.r),
                child: SvgPicture.asset(Assets.drawerIcon),
              ),
            ),
            const SearchWidget()
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const RecommendedWidget(),
              SizedBox(
                height: 20.h,
              ),
              const MyPlaylistWidget(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const PlayingTrack(),
    );
  }
}
