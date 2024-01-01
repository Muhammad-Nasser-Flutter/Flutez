import 'package:flutez/core/helpers/extensions.dart';
import 'package:flutez/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../theming/assets.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>context.pushNamed(Routes.searchScreen),
      child: Container(
        padding: EdgeInsets.all(10.r),
        child: SvgPicture.asset(Assets.searchIcon),
      ),
    );
  }
}
