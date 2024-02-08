import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutez/core/theming/colors.dart';
import 'package:flutez/features/Track/presentation/Shimmers/image_shimmer.dart';
import 'package:flutez/features/home/Bloc/home_cubit.dart';
import 'package:flutez/features/home/Bloc/home_states.dart';
import 'package:flutez/features/home/models/recommended_track_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/custom_texts.dart';

class RecommendedItemWidget extends StatelessWidget {
  final RecommendedTrackModel recommendedTrack;
  final int index;
  const RecommendedItemWidget(
      {super.key, required this.recommendedTrack, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
      },
      child: BlocBuilder<HomeCubit, HomeStates>(
        builder: (context, state) {
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
                          color:
                          AppColors.trackShadowColor
                              .withOpacity(0.2),
                          blurRadius: 35.r,
                          spreadRadius: -25,
                          offset: const Offset(0, 30),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: CachedNetworkImage(
                      placeholder: (context,object){
                        return const ImageShimmer(width: double.maxFinite, height: double.maxFinite);
                      },
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
