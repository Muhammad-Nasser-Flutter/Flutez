import 'package:flutez/core/theming/colors.dart';
import 'package:flutez/core/widgets/custom_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileWidget extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback onPressed;
  const ProfileWidget({super.key, required this.icon, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 15.w,
            ),
            SvgPicture.asset(icon,width: 27.r,color: AppColors.smallTextColor,),
            SizedBox(width: 20.w,),
            Text20(text: label),
            const Spacer(),
            Icon(Icons.arrow_forward_ios,color: Colors.white,size: 20.r,),
            SizedBox(width: 20.w,)
          ],
        ),
      ),
    );
  }
}
