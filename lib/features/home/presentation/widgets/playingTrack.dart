import 'package:flutez/features/Track/Bloc/track_states.dart';
import 'package:flutez/features/Track/Model/artist_model.dart';
import 'package:flutez/features/Track/Model/music_player_data.dart';
import 'package:flutez/features/Track/Model/track_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:just_audio/just_audio.dart';
import '../../../../core/theming/assets.dart';
import '../../../../core/widgets/custom_texts.dart';
import '../../../Track/Bloc/track_cubit.dart';

class PlayingTrack extends StatelessWidget {
  const PlayingTrack({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackCubit,TrackStates>(
      builder:(context,state){
        var trackCubit = TrackCubit.get(context);
        return Container(
          padding: EdgeInsets.only(
            bottom: 10.h,
          ),
          child: IntrinsicHeight(
            child: StreamBuilder<MusicPlayerData>(
              stream: trackCubit.musicPlayerDataStream,
              builder: (context, snapshot) {
                return Column(
                  children: [
                    Slider(
                    value: snapshot.data!.currentSongPosition!.inSeconds.toDouble(),
                    onChanged: (value) {
                      final position = Duration(milliseconds: value.toInt());
                      trackCubit.audioHandler!.seek(position);
                    },
                    min: 0.0,
                    max: snapshot.data?.currentSongDuration?.inSeconds.toDouble()??100,
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
                                  text:
                                  "Chaff & Dust",
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
                        InkWell(
                          onTap: (){},
                          child: Padding(
                            padding: EdgeInsets.all(5.r),
                            child: SvgPicture.asset(
                              Assets.previousIcon,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        InkWell(
                          onTap: (){
                            context.read<TrackCubit>().setCurrentSong(Song(artist: Artist(name: "Imagine Dragons"), title: "Believer", imageUrl: "",trackPath: "assets/songs/Believer.mp3"));
                            context.read<TrackCubit>().play();
                          },
                          child: Padding(
                            padding: EdgeInsets.all(5.r),
                            child: SvgPicture.asset(
                              Assets.pauseIcon,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        InkWell(
                          onTap: (){},
                          child: Padding(
                            padding: EdgeInsets.all(5.r),
                            child: SvgPicture.asset(
                              Assets.nextIcon,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                      ],
                    ),
                  ],
                );
              }
            ),
          ),
        );
      },
    );
  }
}
