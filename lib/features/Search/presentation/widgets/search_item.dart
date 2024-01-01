import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutez/core/helpers/extensions.dart';
import 'package:flutez/core/routing/routes.dart';
import 'package:flutez/core/theming/assets.dart';
import 'package:flutez/core/theming/colors.dart';
import 'package:flutez/core/widgets/custom_texts.dart';
import 'package:flutez/features/Search/models/search_model.dart';
import 'package:flutez/features/Track/Bloc/track_cubit.dart';
import 'package:flutez/features/Track/Bloc/track_states.dart';
import 'package:flutez/features/home/models/recommended_track_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palette_generator/palette_generator.dart';

class SearchItem extends StatelessWidget {
  final SearchModel searchModel;
  const SearchItem({super.key, required this.searchModel});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackCubit, TrackStates>(
      builder: (context, state) {
        var trackCubit = TrackCubit.get(context);
        return GestureDetector(
          onTap: () {
            trackCubit.getTrackLink(
              RecommendedTrackModel(
                author: searchModel.channel!.name,
                thumbnail: searchModel.thumbnails![1].url,
                title: searchModel.title,
                videoId: searchModel.id,
              ),
            );
            context.pushNamed(Routes.playingNowScreen);
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
                        color: trackCubit.shadows[0],
                        blurRadius: 15.r,
                        spreadRadius: -5,
                        offset: const Offset(0, 20),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: searchModel.thumbnails![0].url!,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text18(
                text: "${searchModel.title}",
                overFlow: TextOverflow.ellipsis,
                weight: FontWeight.w500,
              ),
              SizedBox(
                height: 5.h,
              ),
              Text12(
                size: 13.sp,
                text: "${searchModel.channel!.name}",
                weight: FontWeight.w400,
              ),
            ],
          ),
        );
      },
    );
  }
}
