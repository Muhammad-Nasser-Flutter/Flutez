import 'package:flutez/features/home/Bloc/home_cubit.dart';
import 'package:flutez/features/home/presentation/widgets/recommended_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/assets.dart';
import '../../../../core/widgets/custom_texts.dart';

class RecommendedWidget extends StatefulWidget {
  const RecommendedWidget({super.key});

  @override
  State<RecommendedWidget> createState() => _RecommendedWidgetState();
}

class _RecommendedWidgetState extends State<RecommendedWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HomeCubit.get(context).updatePlaylistPaletteGenerator();
    HomeCubit.get(context).updateRecommendedPaletteGenerator();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text24(
          text: "Recommended for you",
          weight: FontWeight.w700,
        ),
        SizedBox(
          height: 20.h,
        ),
        SizedBox(
          height: 280.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return const RecommendedItemWidget();
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
