import 'package:flutez/core/helpers/extensions.dart';
import 'package:flutez/core/routing/routes.dart';
import 'package:flutez/core/theming/assets.dart';
import 'package:flutez/core/widgets/custom_texts.dart';
import 'package:flutez/core/widgets/search_icon.dart';
import 'package:flutez/features/Track/Bloc/track_cubit.dart';
import 'package:flutez/features/Track/Bloc/track_states.dart';
import 'package:flutez/features/home/presentation/widgets/drawer/custom_drawer.dart';
import 'package:flutez/features/home/presentation/widgets/Playlists/my_playlist_widget.dart';
import 'package:flutez/features/home/presentation/widgets/playingTrack.dart';
import 'package:flutez/features/home/presentation/widgets/recommended/recommended_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      bottomNavigationBar: BlocBuilder<TrackCubit,TrackStates>(
        builder: (context, state) {
          var trackCubit = TrackCubit.get(context);
          return trackCubit.currentTrack == null? const SizedBox(): const PlayingTrack();
        },
      ),
    );
  }
}
