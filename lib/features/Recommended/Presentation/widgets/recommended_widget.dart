import 'package:flutez/features/Recommended/Bloc/recommended_cubit.dart';
import 'package:flutez/features/Recommended/Bloc/recommended_states.dart';
import 'package:flutez/features/Track/presentation/Shimmers/recommended_shimmer.dart';
import 'package:flutez/features/home/Bloc/home_cubit.dart';
import 'package:flutez/features/home/Bloc/home_states.dart';
import 'package:flutez/features/Recommended/Presentation/widgets/recommended_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/custom_texts.dart';

class RecommendedWidget extends StatelessWidget {
  const RecommendedWidget({super.key});

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
          height: 250.h,
          child: BlocProvider(
            create: (context) => RecommendedCubit()..getRecommendedTracks(),
            child: BlocBuilder<RecommendedCubit, RecommendedStates>(
              builder: (context, state) {
                var recommendedCubit = RecommendedCubit.get(context);
                return recommendedCubit.recommendedTracks.isNotEmpty
                    ? ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return RecommendedItemWidget(
                              recommendedTrack:
                                  recommendedCubit.recommendedTracks[index],
                              index: index);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            width: 15.w,
                          );
                        },
                        itemCount: recommendedCubit.recommendedTracks.length,
                      )
                    : ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return const RecommendedItemShimmer();
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            width: 15.w,
                          );
                        },
                        itemCount: 5,
                      );
              },
            ),
          ),
        ),
      ],
    );
  }
}
