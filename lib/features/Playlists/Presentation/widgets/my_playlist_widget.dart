import 'package:flutez/features/Playlists/Bloc/playlist_cubit.dart';
import 'package:flutez/features/Playlists/Bloc/playlist_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../core/widgets/custom_texts.dart';
import '../../../Track/presentation/Shimmers/recommended_shimmer.dart';
import 'home_playlist_item_widget.dart';

class PlaylistsWidget extends StatelessWidget {
  const PlaylistsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlaylistCubit()..getPlaylist(),
      child: BlocBuilder<PlaylistCubit, PlaylistStates>(
        builder: (context, state) {
          var playlistCubit = PlaylistCubit.get(context);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text24(
                text: "Playlists",
                weight: FontWeight.w700,
              ),
              SizedBox(
                height: 15.h,
              ),
              SizedBox(
                height: 250.h,
                child:playlistCubit.playlists.isNotEmpty?
                ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return HomePlayListItemWidget(
                      model: playlistCubit.playlists[index],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: 15.w,
                    );
                  },
                  itemCount: playlistCubit.playlists.length,
                ):
                ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return const RecommendedItemShimmer();
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: 15.w,
                    );
                  },
                  itemCount: 5,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
