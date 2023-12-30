import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutez/core/widgets/icon_widget.dart';
import 'package:flutez/features/Track/Bloc/track_cubit.dart';
import 'package:flutez/features/Track/Bloc/track_states.dart';
import 'package:flutez/features/Track/Model/artist_model.dart';
import 'package:flutez/features/Track/Model/music_player_data.dart';
import 'package:flutez/features/Track/Model/position_data.dart';
import 'package:flutez/features/Track/Model/track_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:just_audio/just_audio.dart';
import '../../../../core/theming/assets.dart';
import '../../../../core/widgets/custom_texts.dart';
import 'package:rxdart/rxdart.dart';

class PlayingTrack extends StatefulWidget {
  const PlayingTrack({super.key});

  @override
  State<PlayingTrack> createState() => _PlayingTrackState();
}

class _PlayingTrackState extends State<PlayingTrack> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (TrackCubit.get(context).audioPlayer == null) {
      TrackCubit.get(context).initHandler(
          "https://ytmp3-w1.savevids.net/dl?hash=Rm1ZLCEu14P7aPyYNVCxNNV%2B9TwejWtCegDM7NuH60JW5BzR%2Fh7FmkzZ%2B5NcKgQX6ot%2BXLlZtqQGcjdb1iruOXka%2Bl7hLctH01vDgjGCvG2uWQZZRF67s0Z9aUPFVSufG16Dy76pEccE9lXXN0YOZxj575VdHPBSnzZvngUymYwh3b3rCRZVahjyUeFrKJDxtigxHM6dpzZ008N%2FHlhPZ0kcdru4TSWyUdCoMq6DRNeThB7jMQ6AWMiOr9ECWbI6");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackCubit, TrackStates>(
      builder: (context, state) {
        var trackCubit = TrackCubit.get(context);
        return Container(
          padding: EdgeInsets.only(
            bottom: 10.h,
          ),
          child: IntrinsicHeight(
            child: StreamBuilder<PositionData>(
                stream: trackCubit.positionDataStream,
                builder: (context, snapshot) {
                  final positionData = snapshot.data;
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
                            child: Image.asset(Assets.playingTrackIcon),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 5.w),
                            constraints: BoxConstraints(maxWidth: 160.w),
                            child: IntrinsicHeight(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text18(
                                    text: "Chaff & Dust",
                                    maxLines: 1,
                                    overFlow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Text12(
                                    text: "HYONNA",
                                    maxLines: 1,
                                    overFlow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                          IconWidget(
                            onPressed: () {},
                            iconAsset: Assets.previousIcon,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          IconWidget(
                            onPressed: () {
                              if (!snapshot.data!.state.playing) {
                                trackCubit.audioPlayer!.play();
                              } else if (snapshot.data!.state.processingState !=
                                  ProcessingState.completed) {
                                trackCubit.audioPlayer!.pause();
                              }
                            },
                            iconAsset: Assets.pauseIcon,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          IconWidget(
                            onPressed: () {},
                            iconAsset: Assets.nextIcon,
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                        ],
                      ),
                    ],
                  );
                }),
          ),
        );
      },
    );
  }
}
