import 'package:flutez/core/theming/colors.dart';
import 'package:flutez/features/home/Bloc/home_cubit.dart';
import 'package:flutez/features/home/Bloc/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../../../core/theming/assets.dart';
import '../../../../core/widgets/custom_texts.dart';

class RecommendedItemWidget extends StatelessWidget {
  const RecommendedItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit,HomeStates>(
      builder:(context,state){
        var homeCubit = HomeCubit.get(context);
        return Column(
          children: [
            Expanded(
              child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                width: 190.w,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: homeCubit.recommendedShadows[0],
                      blurRadius: 15.r,
                      spreadRadius: -5,
                      offset: const Offset(0, 20),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Image.asset(
                  Assets.cover1,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text18(
              text: "Monster Go Bump",
              weight: FontWeight.w500,
            ),
            SizedBox(
              height: 5.h,
            ),
            Text12(
              text: "ERIKA RECINOS",
              weight: FontWeight.w400,
            )
          ],
        );
      },
    );
  }
}
