import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutez/core/helpers/extensions.dart';
import 'package:flutez/core/theming/colors.dart';
import 'package:flutez/features/Playlists/models/playlist_model.dart';
import 'package:flutez/features/Recommended/Bloc/recommended_cubit.dart';
import 'package:flutez/features/Track/Bloc/track_cubit.dart';
import 'package:flutez/features/Track/Bloc/track_states.dart';
import 'package:flutez/features/Track/Model/track_model.dart';
import 'package:flutez/features/Track/presentation/Shimmers/image_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/custom_texts.dart';

class RecommendedItemWidget extends StatelessWidget {
  final Track recommendedTrack;
  final int index;
  const RecommendedItemWidget({super.key, required this.recommendedTrack, required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackCubit, TrackStates>(
      builder: (context, state) {
        var trackCubit = TrackCubit.get(context);
        return InkWell(
          onTap: () {
            context.pushNamed(
              Routes.playingNowScreen,
              arguments: recommendedTrack,
            );
            trackCubit.setCurrentTrack(
              playlist: RecommendedCubit.get(context).recommendedTracks  ,
              index: index,
            );
          },
          child: Column(
            children: [
              Expanded(
                child: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  width: 190.w,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.trackShadowColor.withOpacity(0.2),
                        blurRadius: 35.r,
                        spreadRadius: -25,
                        offset: const Offset(0, 30),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Hero(
                    tag: "${recommendedTrack.image}",
                    child: CachedNetworkImage(
                      placeholder: (context, object) {
                        return const ImageShimmer(width: double.maxFinite, height: double.maxFinite);
                      },
                      imageUrl: recommendedTrack.image!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text18(
                text: "${recommendedTrack.trackName}",
                maxLines: 1,
                overFlow: TextOverflow.ellipsis,
                weight: FontWeight.w500,
              ),
              SizedBox(
                height: 5.h,
              ),
              Text12(
                text: "${recommendedTrack.artist}",
                maxLines: 1,
                overFlow: TextOverflow.ellipsis,
                weight: FontWeight.w400,
              )
            ],
          ),
        );
      },
    );
  }
}
