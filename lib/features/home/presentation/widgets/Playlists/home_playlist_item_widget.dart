import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutez/core/helpers/extensions.dart';
import 'package:flutez/core/routing/routes.dart';
import 'package:flutez/core/theming/colors.dart';
import 'package:flutez/features/home/Bloc/home_cubit.dart';
import 'package:flutez/features/home/Bloc/home_states.dart';
import 'package:flutez/features/home/models/playlist_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palette_generator/palette_generator.dart';
import '../../../../../core/theming/assets.dart';
import '../../../../../core/widgets/custom_texts.dart';

class HomePlayListItemWidget extends StatelessWidget {
  const HomePlayListItemWidget({super.key, required this.model});
  final PlaylistModel model ;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.pushNamed(Routes.playlistTracks,arguments: model);
      },
      child: BlocBuilder<HomeCubit,HomeStates>(
        builder:(context,state){
          var homeCubit = HomeCubit.get(context);
          return Column(
            children: [
              Expanded(
                child: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  width: 190.w,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    boxShadow: [
                      BoxShadow(
                        color:Color(int.parse(model.shadowColor!)).withOpacity(0.05),
                        blurRadius: 15.r,
                        spreadRadius: -5,
                        offset: const Offset(0, 20),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: CachedNetworkImage(imageUrl: model.image!,fit: BoxFit.fill,),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text18(
                text: model.title!,
                weight: FontWeight.w500,
              ),
            ],
          );
        },
      ),
    );
  }
}
