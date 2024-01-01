import 'package:flutez/features/home/Bloc/home_cubit.dart';
import 'package:flutez/features/home/Bloc/home_states.dart';
import 'package:flutez/features/home/presentation/widgets/recommended_item_widget.dart';
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
          height: 280.h,
          child: BlocBuilder<HomeCubit,HomeStates>(
            builder:(context,state){
              var homeCubit = HomeCubit.get(context);
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return RecommendedItemWidget(recommendedTrack: homeCubit.recommendedTracks[index],index:index);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 15.w,
                  );
                },
                itemCount: homeCubit.recommendedTracks.length,
              );
            },
          ),
        ),
      ],
    );
  }
}
