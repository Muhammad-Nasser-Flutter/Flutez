import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theming/assets.dart';
import '../../../../core/widgets/custom_texts.dart';

class PlayingTrack extends StatelessWidget {
  const PlayingTrack({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: 10.h,
      ),
      child: IntrinsicHeight(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 70.r,
                  height: 70.r,
                  child: Image.asset(Assets.playingTrackIcon),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5.w),
                  constraints: BoxConstraints(maxWidth: 160.w),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text18(
                          text:
                          "Chaff & DustChaff & DustChaff & DustChaff & Dust",
                          maxLines: 1,
                          overFlow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Text12(
                          text: "HYONNA",
                          maxLines: 1,
                          overFlow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: (){},
                  child: Padding(
                    padding: EdgeInsets.all(5.r),
                    child: SvgPicture.asset(
                      Assets.previousIcon,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                InkWell(
                  onTap: (){},
                  child: Padding(
                    padding: EdgeInsets.all(5.r),
                    child: SvgPicture.asset(
                      Assets.pauseIcon,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                InkWell(
                  onTap: (){},
                  child: Padding(
                    padding: EdgeInsets.all(5.r),
                    child: SvgPicture.asset(
                      Assets.nextIcon,
                    ),
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
