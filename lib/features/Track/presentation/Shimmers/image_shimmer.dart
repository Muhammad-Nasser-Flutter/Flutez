import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/theming/colors.dart';

class ImageShimmer extends StatelessWidget {
  final double width;
  final double height;
  const ImageShimmer({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      enabled: true,
      baseColor: Colors.white,
      highlightColor: AppColors.smallTextColor,
      direction: ShimmerDirection.ltr,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            color: Colors.grey.withOpacity(0.5)
        ),
        height: height,
        width: width,
      ),
    );
  }
}
