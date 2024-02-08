import 'package:flutez/core/theming/colors.dart';
import 'package:flutez/features/Track/presentation/Shimmers/image_shimmer.dart';
import 'package:flutez/features/Track/presentation/Shimmers/text_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecommendedItemShimmer extends StatelessWidget {
  const RecommendedItemShimmer(
      {super.key,});

  @override
  Widget build(BuildContext context) {
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
              child: ImageShimmer(width: 190.w, height: double.maxFinite),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          const TextShimmer(width: 0.4),
          SizedBox(
            height: 5.h,
          ),
          const TextShimmer(width: 0.2),

        ],
      ),
    );
  }
}
