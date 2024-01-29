import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutez/core/helpers/extensions.dart';
import 'package:flutez/core/theming/assets.dart';
import 'package:flutez/core/theming/colors.dart';
import 'package:flutez/core/widgets/custom_texts.dart';
import 'package:flutez/core/widgets/icon_widget.dart';
import 'package:flutez/features/Track/Bloc/track_cubit.dart';
import 'package:flutez/features/Track/Bloc/track_states.dart';
import 'package:flutez/features/Track/Model/position_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:palette_generator/palette_generator.dart';

class PlayingNowScreen extends StatefulWidget {
  const PlayingNowScreen({super.key});

  @override
  State<PlayingNowScreen> createState() => _PlayingNowScreenState();
}

class _PlayingNowScreenState extends State<PlayingNowScreen> {
  // PaletteGenerator? _paletteGenerator;
  // Color? shadowColor = Colors.grey.withOpacity(0.3);
  @override
  void initState() {
    super.initState();
    // Load your image here and get its dominant color
    TrackCubit.get(context).updatePlayingPaletteGenerator();
    if (TrackCubit.get(context).audioPlayer == null) {
      TrackCubit.get(context).initHandler(
          "https://ymd.dlod.link/?u=https%3A%2F%2Fredirector.googlevideo.com%2Fvideoplayback%3Fexpire%3D1704145545%26ei%3DKd6SZeC4HvutsfIP1ISC4A8%26ip%3D209.141.44.95%26id%3Do-ANvD4I33444mLqiFsIFuWi2mqP2STaiCpFQdJ9Am05N8%26itag%3D140%26source%3Dyoutube%26requiressl%3Dyes%26xpc%3DEgVo2aDSNQ%253D%253D%26mh%3DVZ%26mm%3D31%252C29%26mn%3Dsn-nx5s7nee%252Csn-nx57ynse%26ms%3Dau%252Crdu%26mv%3Dm%26mvi%3D4%26pl%3D22%26gcr%3Dus%26initcwndbps%3D127500%26siu%3D1%26vprv%3D1%26svpuc%3D1%26mime%3Daudio%252Fmp4%26ns%3DncxU_eSpZVNAl7X8jSa8NGgQ%26gir%3Dyes%26clen%3D3506059%26dur%3D216.595%26lmt%3D1699039483710674%26mt%3D1704123433%26fvip%3D3%26keepalive%3Dyes%26fexp%3D24007246%26c%3DWEB%26txp%3D4532434%26n%3D39b3ePAy1NoD5Q%26sparams%3Dexpire%252Cei%252Cip%252Cid%252Citag%252Csource%252Crequiressl%252Cxpc%252Cgcr%252Csiu%252Cvprv%252Csvpuc%252Cmime%252Cns%252Cgir%252Cclen%252Cdur%252Clmt%26lsparams%3Dmh%252Cmm%252Cmn%252Cms%252Cmv%252Cmvi%252Cpl%252Cinitcwndbps%26lsig%3DAAO5W4owRAIgBARtmlqS1U_QGbFMlWAt5BU-kwkjOI3mPTFGgola6ncCIDZnJk3P6o1ICsVjUMv2CCuVGoEA7rf5X2UsXGTFwu4f%26sig%3DAJfQdSswRQIgH-vxtHn-h2G08fO80MGb-cDd19PEsMPQ4NT8vvjN6PwCIQDpiD_UCk8gnRgJ4sG-o3i7I3soHeuvHEaCHAIJ1wjy5w%253D%253D%26range%3D0-&p=Ip9LiUpGmxEeKfRQT5EjpKsHrir4pPmIeiAjHclnD18fEZBYIR4D8GwngHjBlB12CFFjlZeLsiTAmopNl-kHI1KsU7ghnUciQieFvGGYor3M4j017gJhPpQpkla4FOisXuTx1pkYUTw2VGX1lw9mYA&s=mOLCb2jncSEFwJ_r-P2DEVo0gbvgPj1To6_YgkTl5aU");
    }
  }

  // Future<void> _updatePaletteGenerator() async {
  //   // Replace 'your_image_path.jpg' with the actual path to your image
  //   const imageProvider = AssetImage(Assets.cover3);
  //
  //   PaletteGenerator paletteGenerator =
  //       await PaletteGenerator.fromImageProvider(imageProvider);
  //
  //   setState(() {
  //     _paletteGenerator = paletteGenerator;
  //     shadowColor = _paletteGenerator?.vibrantColor?.color.withOpacity(0.1);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackCubit, TrackStates>(
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
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
                  Center(
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        SizedBox(
                          height: 280.r,
                          width: double.maxFinite,
                        ),
                        Positioned(
                          left: -180.r,
                          top: 0,
                          bottom: 0,
                          child: Center(
                            child: Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              width: 220.r,
                              height: 220.r,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.scaffoldBackground,
                                    blurRadius: 15.r,
                                    spreadRadius: -5,
                                    offset: const Offset(0, 20),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              child: Image.asset(
                                Assets.cover3,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          width: 260.r,
                          height: 260.r,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: trackCubit.playingNowShadow??AppColors.scaffoldBackground,
                                blurRadius: 45.r,
                                spreadRadius: -0,
                                offset: const Offset(0, 0),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: trackCubit.currentTrack!.image!,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          bottom: 0,
                          right: -180.r,
                          child: Center(
                            child: Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              width: 220.r,
                              height: 220.r,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.scaffoldBackground,
                                    blurRadius: 15.r,
                                    spreadRadius: -5,
                                    offset: const Offset(0, 20),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              child: Image.asset(
                                Assets.cover3,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 40.w,
                      ),
                      Column(
                        children: [
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: 260.w
                            ),
                            child: Text22(
                              text: "${trackCubit.currentTrack?.trackName}",maxLines: 1,overFlow: TextOverflow.ellipsis,
                              textColor: Colors.white,
                            ),
                          ),
                          Text16(
                            text: "${trackCubit.currentTrack?.artist}",
                            weight: FontWeight.w300,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconWidget(
                          onPressed: () {},
                          iconAsset: Assets.heartIcon,
                          size: 22.r,
                        ),
                      ),
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
                          onPressed: () {},
                          iconAsset: Assets.volumeIcon,
                          size: 22.r,
                        ),
                        const Spacer(),
                        IconWidget(
                          onPressed: () {},
                          iconAsset: Assets.repeatIcon,
                          size: 22.r,
                        ),
                        IconWidget(
                          onPressed: () {},
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
                        onPressed: () {},
                        iconAsset: Assets.previousIcon,
                        size: 35.r,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      IconWidget(
                        onPressed: () {
                          if (!positionData!.state.playing) {
                            trackCubit.audioPlayer!.play();
                          } else if (positionData.state.processingState !=
                              ProcessingState.completed) {
                            trackCubit.audioPlayer!.pause();
                          }
                        },
                        iconAsset: positionData?.state.playing == null
                            ? Assets.playIcon
                            : !positionData!.state.playing
                            ? Assets.playIcon
                            : Assets.pauseIcon,
                        size: 40.r,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      IconWidget(
                        onPressed: () {},
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
    );
  }
}
