import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutez/core/widgets/icon_widget.dart';
import 'package:flutez/features/Track/Bloc/track_cubit.dart';
import 'package:flutez/features/Track/Bloc/track_states.dart';
import 'package:flutez/features/Track/Model/position_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import '../../../../core/theming/assets.dart';
import '../../../../core/widgets/custom_texts.dart';

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
          "https://ytmp3.savevids.net/dl?hash=zfkoTLHBnJvxSYCc5if12HVIhQ6cKhKVw%2Fa6DcCOaMBLU2y2xsdupPJX0W43ZB8OkbAIsqrT0ItSD9ZLFfsCuPc%2F7dxCFLVw3iXkOFMF3qqQiME%2BrN7JCt2ed%2FvE1hesBCZ%2BVoWmxok%2B3U7wqIiQ5inMNKm235sualf%2Fyrqrdax3mzCB%2BO5KNCBS0pBwOmy8ALq9WUo2BUT1TatdGWMsCwIIQ3QBM5AfDIjw27dj%2FA6IiKoBmwdHKMXfuVhb3ZuJ");
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
                      buffered: positionData?.bufferedPosition ?? Duration.zero,
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
              },
            ),
          ),
        );
      },
    );
  }
}
