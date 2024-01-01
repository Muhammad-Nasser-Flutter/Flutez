import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class IconWidget extends StatelessWidget {
  IconWidget({
    super.key,
    required this.onPressed,
    required this.iconAsset,
    this.size,
    this.color,
  });
  final VoidCallback onPressed;
  final String iconAsset;
  double? size;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(10.r),
        child: SvgPicture.asset(
          iconAsset,
          width: size,
          color: color,
        ),
      ),
    );
  }
}
