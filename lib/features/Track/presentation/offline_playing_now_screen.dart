import 'dart:io';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutez/core/helpers/extensions.dart';
import 'package:flutez/core/theming/assets.dart';
import 'package:flutez/core/theming/colors.dart';
import 'package:flutez/core/widgets/custom_texts.dart';
import 'package:flutez/core/widgets/icon_widget.dart';
import 'package:flutez/features/Track/Bloc/track_cubit.dart';
import 'package:flutez/features/Track/Bloc/track_states.dart';
import 'package:flutez/features/Track/Model/position_data.dart';
import 'package:flutez/features/Track/presentation/Shimmers/image_shimmer.dart';
import 'package:flutez/features/Track/presentation/Shimmers/text_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import '../../Favorites/Bloc/favorites_cubit.dart';

class OfflinePlayingNowScreen extends StatelessWidget {
  const OfflinePlayingNowScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoritesCubit()..getFavorites(),
      child: BlocBuilder<TrackCubit, TrackStates>(
        builder: (context, state) {
          var trackCubit = TrackCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconWidget(
                    onPressed: () {
                      context.pop();
                    },
                    iconAsset: Assets.arrowBackIcon,
                  ),
                  Text18(
                    text: "Playing Now",
                    textColor: const Color(0xFFDBE6FF),
                  ),
                  SizedBox(
                    width: 30.w,
                  )
                ],
              ),
            ),
            body: StreamBuilder<PositionData>(
              stream: trackCubit.positionDataStream,
              builder: (context, snapshot) {
                final positionData = snapshot.data;
                final mediaItem = positionData?.sequenceState?.currentSource?.tag;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40.h,
                    ),
                    Center(
                      child: Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        width: 300.r,
                        height: 300.r,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.trackShadowColor.withOpacity(0.2),
                              blurRadius: 45.r,
                              spreadRadius: -0,
                              offset: const Offset(0, 0),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: mediaItem != null
                            ? Image.file(
                                File(mediaItem.album.toString()),
                                fit: BoxFit.cover,
                              )
                            : ImageShimmer(width: 300.r, height: 300.r),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Column(
                      children: [
                        Container(
                          constraints: BoxConstraints(maxWidth: 260.w),
                          child: mediaItem != null
                              ? Text22(
                                  text: mediaItem.title,
                                  maxLines: 1,
                                  overFlow: TextOverflow.ellipsis,
                                  textColor: Colors.white,
                                )
                              : const TextShimmer(width: 0.5),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        mediaItem != null
                            ? Text16(
                                text: "${mediaItem.artist}",
                                weight: FontWeight.w300,
                              )
                            : const TextShimmer(width: 0.3),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        children: [
                          IconWidget(
                            onPressed: () {
                              trackCubit.mute();
                            },
                            iconAsset: trackCubit.volumeIcon(),
                            size: 22.r,
                          ),
                          Expanded(
                            child: ProgressBar(
                              timeLabelLocation: TimeLabelLocation.none,
                              barHeight: 3,
                              baseBarColor: const Color(0xFF555b6a),
                              bufferedBarColor: Colors.grey,
                              progressBarColor: Colors.white,
                              thumbColor: Colors.white,
                              thumbGlowRadius: 20,
                              thumbRadius: 7,
                              progress: Duration(
                                seconds: int.parse(
                                  (trackCubit.audioPlayer!.volume * 100).round().toString(),
                                ),
                              ),
                              total: const Duration(seconds: 100),
                              onSeek: (Duration d) {
                                trackCubit.changeVolume(double.parse((d.inSeconds / 100).toString()));
                              },
                            ),
                          ),
                          SizedBox(
                            width: 50.w,
                          ),
                          // const Spacer(),
                          IconWidget(
                            onPressed: () {
                              trackCubit.changeLoopMode();
                              debugPrint(trackCubit.audioPlayer!.loopMode.name);
                            },
                            iconAsset: trackCubit.loopIcon(),
                            size: 22.r,
                          ),
                          IconWidget(
                            onPressed: () {
                              trackCubit.changeShuffleMode();
                            },
                            iconAsset: Assets.shuffleIcon,
                            size: 22.r,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 25.w),
                      child: ProgressBar(
                        barHeight: 4,
                        baseBarColor: const Color(0xFF555b6a),
                        bufferedBarColor: Colors.grey,
                        progressBarColor: Colors.white,
                        timeLabelPadding: 15.h,
                        thumbColor: Colors.white,
                        thumbGlowRadius: 20,
                        thumbRadius: 9,
                        timeLabelLocation: TimeLabelLocation.above,
                        timeLabelTextStyle: TextStyle(
                          color: AppColors.smallTextColor,
                          fontWeight: FontWeight.w300,
                          fontSize: 14.sp,
                        ),
                        progress: positionData?.position ?? Duration.zero,
                        total: positionData?.duration ?? Duration.zero,
                        buffered: positionData?.bufferedPosition ?? Duration.zero,
                        onSeek: trackCubit.audioPlayer!.seek,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconWidget(
                          onPressed: () {
                            trackCubit.seekToPrevTrack();
                          },
                          iconAsset: Assets.previousIcon,
                          size: 35.r,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        IconWidget(
                          onPressed: () {
                            if (!positionData!.playerState.playing) {
                              trackCubit.audioPlayer!.play();
                            } else if (positionData.playerState.processingState != ProcessingState.completed) {
                              trackCubit.audioPlayer!.pause();
                            }
                          },
                          iconAsset: positionData?.playerState.playing == null
                              ? Assets.playIcon
                              : !positionData!.playerState.playing
                                  ? Assets.playIcon
                                  : Assets.pauseIcon,
                          size: 40.r,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        IconWidget(
                          onPressed: () {
                            trackCubit.seekToNextTrack();
                          },
                          iconAsset: Assets.nextIcon,
                          size: 35.r,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 60.h,
                    )
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
