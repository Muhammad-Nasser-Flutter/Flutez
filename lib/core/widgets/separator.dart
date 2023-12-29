import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theming/colors.dart';

class Separator extends StatelessWidget {
  double? margin ;
  Separator({super.key,this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: margin??0),
      width: double.maxFinite,
      height: 1.h,
      color: Colors.grey.withOpacity(0.3),
    );
  }
}