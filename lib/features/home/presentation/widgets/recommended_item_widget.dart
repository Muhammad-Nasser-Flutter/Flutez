import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutez/core/theming/colors.dart';
import 'package:flutez/features/Track/Bloc/track_cubit.dart';
import 'package:flutez/features/home/Bloc/home_cubit.dart';
import 'package:flutez/features/home/Bloc/home_states.dart';
import 'package:flutez/features/home/models/recommended_track_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../../../core/theming/assets.dart';
import '../../../../core/widgets/custom_texts.dart';

class RecommendedItemWidget extends StatelessWidget {
  final RecommendedTrackModel recommendedTrack;
  final int index;
  const RecommendedItemWidget(
      {super.key, required this.recommendedTrack, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        TrackCubit.get(context).getTrackLink(recommendedTrack);
      },
      child: BlocBuilder<HomeCubit, HomeStates>(
        builder: (context, state) {
          var homeCubit = HomeCubit.get(context);
          return SizedBox(
            width: 200.w,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    width: 190.w,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: homeCubit.recommendedShadows[index] ??
                              AppColors.scaffoldBackground,
                          blurRadius: 15.r,
                          spreadRadius: -5,
                          offset: const Offset(0, 20),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: recommendedTrack.thumbnail!,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text18(
                  text: "${recommendedTrack.title}",
                  maxLines: 1,
                  overFlow: TextOverflow.ellipsis,
                  weight: FontWeight.w500,
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text12(
                  text: "${recommendedTrack.author}",
                  maxLines: 1,
                  overFlow: TextOverflow.ellipsis,
                  weight: FontWeight.w400,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
