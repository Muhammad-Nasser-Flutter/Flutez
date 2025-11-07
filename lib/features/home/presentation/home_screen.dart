import 'package:flutez/core/widgets/search_icon.dart';
import 'package:flutez/features/home/presentation/widgets/downloaded_tracks_widgets/downloaded_tracks_section.dart';
import 'package:flutez/features/home/presentation/widgets/drawer/custom_drawer.dart';
import 'package:flutez/features/Track/presentation/widgets/playingTrack.dart';
import 'package:flutez/features/Recommended/Presentation/widgets/recommended_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Playlists/Presentation/widgets/my_playlist_widget.dart';

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
      body: PopScope(
        canPop: false,
        child: Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const RecommendedWidget(),
                SizedBox(
                  height: 20.h,
                ),
                const PlaylistsWidget(),
                SizedBox(
                  height: 20.h,
                ),
                const DownloadedTracksSection()
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const PlayingTrack(),
    );
  }
}
