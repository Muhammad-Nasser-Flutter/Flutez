import 'package:flutez/core/helpers/extensions.dart';
import 'package:flutez/core/theming/assets.dart';
import 'package:flutez/core/widgets/custom_texts.dart';
import 'package:flutez/core/widgets/icon_widget.dart';
import 'package:flutez/core/widgets/search_icon.dart';
import 'package:flutez/features/home/models/playlist_model.dart';
import 'package:flutez/features/home/presentation/widgets/playingTrack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Favorites/presentation/widgets/liked_song_item.dart';

class PlaylistTracksScreen extends StatefulWidget {
  const PlaylistTracksScreen({super.key, required this.model});
  final PlaylistModel model;

  @override
  State<PlaylistTracksScreen> createState() => _PlaylistTracksScreenState();
}

class _PlaylistTracksScreenState extends State<PlaylistTracksScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // TrackCubit.get(context).updatePaletteGenerator();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconWidget(
              onPressed: () {
                context.pop();
              },
              iconAsset: Assets.arrowBackIcon,
            ),
            Text24(
              text: widget.model.title!,
              textColor: Colors.white,
            ),
            const SearchWidget()
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.model.tracks!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  return  TrackItem(model: widget.model.tracks![index],index: index, playlistModel: widget.model,);
                },
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar:const PlayingTrack(),
    );
  }
}
