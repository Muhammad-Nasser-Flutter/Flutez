import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutez/core/helpers/extensions.dart';
import 'package:flutez/core/routing/routes.dart';
import 'package:flutez/core/widgets/icon_widget.dart';
import 'package:flutez/features/Track/Bloc/track_cubit.dart';
import 'package:flutez/features/Track/Bloc/track_cubit.dart';
import 'package:flutez/features/Track/Bloc/track_states.dart';
import 'package:flutez/features/Track/Model/position_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import '../../../../core/theming/assets.dart';
import '../../../../core/widgets/custom_texts.dart';

class PlayingTrack extends StatelessWidget {
  const PlayingTrack({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackCubit, TrackStates>(
      builder: (context, state) {
        var trackCubit = TrackCubit.get(context);
        return trackCubit.currentTrack == null? const SizedBox():GestureDetector(
          onTap: () {
            context.pushNamed(Routes.playingNowScreen,arguments: trackCubit.currentTrack);
          },
          child: Container(
            padding: EdgeInsets.only(
              bottom: 10.h,
            ),
            child: IntrinsicHeight(
              child: StreamBuilder<PositionData>(
                stream: trackCubit.positionDataStream,
                builder: (context, snapshot) {
                  final positionData = snapshot.data;
                  final mediaItem =
                      positionData?.sequenceState?.currentSource?.tag;
                  return Column(
                    children: [
                      ProgressBar(
                        barHeight: 4,
                        baseBarColor: const Color(0xFF555b6a),
                        bufferedBarColor: Colors.grey,
                        progressBarColor: Colors.white,
                        timeLabelPadding: 0,
                        thumbColor: Colors.white,
                        thumbGlowRadius: 20,
                        timeLabelLocation: TimeLabelLocation.none,
                        progress: positionData?.position ?? Duration.zero,
                        total: positionData?.duration ?? Duration.zero,
                        buffered:
                            positionData?.bufferedPosition ?? Duration.zero,
                        onSeek: trackCubit.audioPlayer!.seek,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 70.r,
                            height: 70.r,
                            child: CachedNetworkImage(
                              imageUrl: mediaItem.artUri.toString(),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 5.w),
                            constraints: BoxConstraints(maxWidth: 160.w),
                            child: IntrinsicHeight(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text18(
                                    text: "${mediaItem.title}",
                                    maxLines: 1,
                                    overFlow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Text12(
                                    text: "${mediaItem.artist}",
                                    maxLines: 1,
                                    overFlow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                          IconWidget(
                            onPressed: () {
                              trackCubit.seekToPrevTrack();
                            },
                            iconAsset: Assets.previousIcon,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          IconWidget(
                            onPressed: () {
                              if (!positionData!.playerState.playing) {
                                trackCubit.audioPlayer!.play();
                              } else if (positionData.playerState.processingState !=
                                  ProcessingState.completed) {
                                trackCubit.audioPlayer!.pause();
                              }
                            },
                            iconAsset: positionData?.playerState.playing == null
                                ? Assets.playIcon
                                : !positionData!.playerState.playing
                                    ? Assets.playIcon
                                    : Assets.pauseIcon,
                            size: 20.r,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          IconWidget(
                            onPressed: () {
                              trackCubit.seekToNextTrack();
                            },
                            iconAsset: Assets.nextIcon,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
