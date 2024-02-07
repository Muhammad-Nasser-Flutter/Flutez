import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutez/core/helpers/extensions.dart';
import 'package:flutez/core/routing/routes.dart';
import 'package:flutez/core/theming/colors.dart';
import 'package:flutez/core/widgets/custom_texts.dart';
import 'package:flutez/features/Track/Bloc/track_cubit.dart';
import 'package:flutez/features/Track/Bloc/track_states.dart';
import 'package:flutez/features/Playlists/models/playlist_model.dart';
import 'package:flutez/features/Track/presentation/Shimmers/image_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Model/track_model.dart';

class TrackItem extends StatelessWidget {
  const TrackItem({super.key, required this.model, required this.index, required this.playlistModel});
  final Track model;
  final PlaylistModel playlistModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackCubit, TrackStates>(
      builder: (context, state) {
        var trackCubit = TrackCubit.get(context);
        return GestureDetector(
          onTap: () {
            context.pushNamed(
              Routes.playingNowScreen,
              arguments: model,
            );
            if(trackCubit.audioPlayer?.sequenceState?.currentSource?.tag.album != model.trackLink){
              trackCubit.setCurrentTrack(
                  trackImgUrl: model.image!,
                  trackUrl: model.trackLink!,
                  title: model.trackName!,
                  author: model.artist!,
                  playlist: playlistModel,
                  index: index
              );
            }

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
                        color:
                            AppColors.trackShadowColor
                                .withOpacity(0.2),
                        blurRadius: 35.r,
                        spreadRadius: -25,
                        offset: const Offset(0, 30),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Hero(
                    tag: "${model.image}",
                    child: CachedNetworkImage(
                      placeholder: (context,s){
                        return ImageShimmer(height:190.h,width: 190.w,);
                      },
                      errorWidget: (context,s,a){
                        return ImageShimmer(height:190.h,width: 190.w,);
                      },
                      imageUrl: model.image!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text18(
                text: model.trackName!,
                maxLines: 1,
                overFlow: TextOverflow.ellipsis,
                weight: FontWeight.w500,
              ),
              SizedBox(
                height: 5.h,
              ),
              Text12(
                size: 13.sp,
                text: model.artist!,
                weight: FontWeight.w400,
                maxLines: 1,
                overFlow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }
}
