import 'package:flutez/core/helpers/extensions.dart';
import 'package:flutez/core/theming/assets.dart';
import 'package:flutez/core/theming/colors.dart';
import 'package:flutez/core/widgets/custom_text_form_field.dart';
import 'package:flutez/core/widgets/custom_texts.dart';
import 'package:flutez/core/widgets/icon_widget.dart';
import 'package:flutez/features/Search/Bloc/search_cubit.dart';
import 'package:flutez/features/Search/Bloc/search_states.dart';
import 'package:flutez/features/Search/presentation/widgets/search_item.dart';
import 'package:flutez/features/home/presentation/widgets/playingTrack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  var controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconWidget(
              onPressed: () => context.pop(),
              iconAsset: Assets.arrowBackIcon,
            ),
            Text20(
              text: "Search",
              weight: FontWeight.w700,
            ),
            SizedBox(
              width: 50.w,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<SearchCubit, SearchStates>(
          builder: (context, state) {
            var searchCubit = SearchCubit.get(context);
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          borderWidth: 1,
                          controller: controller,
                          hintText: "Search desired track ..",
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          maxLines: 1,
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      InkWell(
                        onTap: () {
                          if (controller.text.isNotEmpty) {
                            searchCubit.searchTracks(controller.text);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.smallTextColor,
                              borderRadius: BorderRadius.circular(12.r),
                              border:
                                  Border.all(width: 1, color: Colors.white)),
                          padding: const EdgeInsets.all(14.0),
                          child: SvgPicture.asset(Assets.searchIcon),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: searchCubit.searches.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                    ),
                    itemBuilder: (context, index) {
                      return SearchItem(
                        searchModel: searchCubit.searches[index],
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: const PlayingTrack(),
    );
  }
}
