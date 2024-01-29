import 'package:flutez/features/home/Bloc/home_cubit.dart';
import 'package:flutez/features/home/Bloc/home_states.dart';
import 'package:flutez/features/home/presentation/widgets/home_playlist_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/assets.dart';
import '../../../../core/widgets/custom_texts.dart';

class MyPlaylistWidget extends StatefulWidget {
  const MyPlaylistWidget({super.key});

  @override
  State<MyPlaylistWidget> createState() => _MyPlaylistWidgetState();
}

class _MyPlaylistWidgetState extends State<MyPlaylistWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HomeCubit.get(context).updatePlaylistPaletteGenerator();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit,HomeStates>(
      builder:(context,state){
        var homeCubit = HomeCubit.get(context);
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
                  return  HomePlayListItemWidget(model: homeCubit.playlists[index],);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 15.w,
                  );
                },
                itemCount: homeCubit.playlists.length,
              ),
            ),
          ],
        );
      },
    );
  }
}
