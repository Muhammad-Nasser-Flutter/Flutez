import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutez/core/helpers/extensions.dart';
import 'package:flutez/core/widgets/custom_texts.dart';
import 'package:flutez/features/Playlists/models/playlist_model.dart';
import 'package:flutez/features/Search/Bloc/search_cubit.dart';
import 'package:flutez/features/Search/Bloc/search_states.dart';
import 'package:flutez/features/Search/models/search_model.dart';
import 'package:flutez/features/Track/Bloc/track_cubit.dart';
import 'package:flutez/features/Track/Bloc/track_states.dart';
import 'package:flutez/features/Track/Model/track_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routing/routes.dart';
import '../../../Track/presentation/Shimmers/image_shimmer.dart';

class SearchItem extends StatelessWidget {
  final Track searchModel;
  final int index;
  const SearchItem({super.key, required this.searchModel, required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackCubit, TrackStates>(
      builder: (context, state) {
        var trackCubit = TrackCubit.get(context);
        return BlocBuilder<SearchCubit,SearchStates>(
          builder:(context,state){
            return GestureDetector(
              onTap: () {
                context.pushNamed(
                  Routes.playingNowScreen,
                  arguments: searchModel,
                );
                if(trackCubit.audioPlayer?.sequenceState?.currentSource?.tag.album != searchModel.trackLink && state is SearchSuccessState){
                  trackCubit.setCurrentTrack(
                     playlist: PlaylistModel(tracks: state.searches),
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
                            // color: trackCubit.shadows[0],
                            blurRadius: 15.r,
                            spreadRadius: -5,
                            offset: const Offset(0, 20),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: CachedNetworkImage(
                        placeholder: (context,object){
                          return const ImageShimmer(width: double.maxFinite, height: double.maxFinite);
                        },
                        imageUrl: searchModel.image!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text18(
                    text: "${searchModel.trackName}",
                    overFlow: TextOverflow.ellipsis,
                    weight: FontWeight.w500,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text12(
                    size: 13.sp,
                    text: "${searchModel.artist}",
                    weight: FontWeight.w400,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
