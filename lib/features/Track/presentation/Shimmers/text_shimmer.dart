import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/theming/colors.dart';

class TextShimmer extends StatelessWidget {
  final double width;
  const TextShimmer({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      enabled: true,
      baseColor: Colors.white,
      highlightColor: AppColors.smallTextColor,
      direction: ShimmerDirection.ltr,
      loop: 1,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(5.r),
        ),
        width: MediaQuery.sizeOf(context).width * width,
        height: 20.h,
      ),
    );
  }
}
