import 'package:flutez/core/widgets/search_icon.dart';
import 'package:flutez/features/home/presentation/widgets/drawer/custom_drawer.dart';
import 'package:flutez/features/home/presentation/widgets/playingTrack.dart';
import 'package:flutez/features/home/presentation/widgets/recommended/recommended_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Playlists/my_playlist_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        actions: [
          const SearchWidget(),
          SizedBox(
            width: 15.w,
          )
        ],
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
