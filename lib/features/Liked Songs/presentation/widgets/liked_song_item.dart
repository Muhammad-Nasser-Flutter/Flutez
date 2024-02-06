import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutez/core/helpers/extensions.dart';
import 'package:flutez/core/routing/routes.dart';
import 'package:flutez/core/widgets/custom_texts.dart';
import 'package:flutez/features/Track/Bloc/track_cubit.dart';
import 'package:flutez/features/Track/Bloc/track_states.dart';
import 'package:flutez/features/home/models/playlist_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LikedSongItem extends StatelessWidget {
  const LikedSongItem({super.key, required this.model, required this.index});
  final PlaylistModel model;
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
              arguments: model.tracks![index],
            );
            trackCubit.setCurrentTrack(
              trackImgUrl: model.tracks![index].image!,
              trackUrl: model.tracks![index].trackLink!,
              title: model.tracks![index].trackName!,
              author: model.tracks![index].artist!,
              id: model.tracks![index].id!,
              shadowColor: model.tracks![index].shadowColor!,
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
                        color:
                            Color(int.parse(model.tracks![index].shadowColor!))
                                .withOpacity(0.2),
                        blurRadius: 35.r,
                        spreadRadius: -25,
                        offset: const Offset(0, 30),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Hero(
                    tag: "${model.tracks![index].image}",
                    child: CachedNetworkImage(
                      imageUrl: model.tracks![index].image!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text18(
                text: model.tracks![index].trackName!,
                maxLines: 1,
                overFlow: TextOverflow.ellipsis,
                weight: FontWeight.w500,
              ),
              SizedBox(
                height: 5.h,
              ),
              Text12(
                size: 13.sp,
                text: model.tracks![index].artist!,
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
