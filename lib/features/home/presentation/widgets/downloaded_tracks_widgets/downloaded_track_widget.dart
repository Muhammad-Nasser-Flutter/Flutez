import 'dart:io';

import 'package:flutez/core/helpers/extensions.dart';
import 'package:flutez/core/routing/routes.dart';
import 'package:flutez/core/theming/colors.dart';
import 'package:flutez/core/widgets/custom_texts.dart';
import 'package:flutez/features/Downloads/Bloc/cubit/downloaded_tracks_cubit.dart';
import 'package:flutez/features/Downloads/models/downloaded_track_model.dart';
import 'package:flutez/features/Track/Bloc/track_cubit.dart';
import 'package:flutez/features/Track/Bloc/track_states.dart';
import 'package:flutez/features/Track/presentation/Shimmers/image_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DownloadedTrackWidget extends StatelessWidget {
  final DownloadedTrackModel downloadedTrackModel;
  final int index;
  const DownloadedTrackWidget({super.key, required this.downloadedTrackModel, required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackCubit, TrackStates>(
      builder: (context, state) {
        var trackCubit = TrackCubit.get(context);
        return InkWell(
          onTap: () {
            context.pushNamed(
              Routes.playingNowOfflineScreen,
            );
            trackCubit.setCurrentTrack(
              playlist: context.read<DownloadedTracksCubit>().state,
              index: index,
              isOffline: true
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
                    tag: downloadedTrackModel.localImagePath,
                    child: Image.file(
                      File(downloadedTrackModel.localImagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text18(
                text: downloadedTrackModel.title,
                maxLines: 1,
                overFlow: TextOverflow.ellipsis,
                weight: FontWeight.w500,
              ),
              SizedBox(
                height: 5.h,
              ),
              Text12(
                text: downloadedTrackModel.artist,
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
