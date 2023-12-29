import 'package:flutez/features/home/presentation/widgets/home_playlist_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/assets.dart';
import '../../../../core/widgets/custom_texts.dart';

class MyPlaylistWidget extends StatelessWidget {
  const MyPlaylistWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text24(
          text: "My Playlist",
          weight: FontWeight.w700,
        ),
        SizedBox(
          height: 15.h,
        ),
        SizedBox(
          height: 250.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return const HomePlayListItemWidget();
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: 15.w,
              );
            },
            itemCount: 5,
          ),
        ),
      ],
    );
  }
}
