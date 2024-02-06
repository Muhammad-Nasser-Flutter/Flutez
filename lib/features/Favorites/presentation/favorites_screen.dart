import 'package:flutez/core/helpers/extensions.dart';
import 'package:flutez/core/theming/assets.dart';
import 'package:flutez/core/widgets/custom_texts.dart';
import 'package:flutez/core/widgets/icon_widget.dart';
import 'package:flutez/core/widgets/search_icon.dart';
import 'package:flutez/features/Favorites/Bloc/favorites_cubit.dart';
import 'package:flutez/features/Favorites/Bloc/favorites_states.dart';
import 'package:flutez/features/Favorites/presentation/widgets/liked_song_item.dart';
import 'package:flutez/features/home/models/playlist_model.dart';
import 'package:flutez/features/home/presentation/widgets/playingTrack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

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
              text: "Favorite Tracks",
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
              BlocBuilder<FavoritesCubit, FavoritesStates>(
                builder: (context, state) {
                  var favCubit = FavoritesCubit.get(context);
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: favCubit.favorites.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                    ),
                    itemBuilder: (context, index) {
                      return TrackItem(
                        model: favCubit.favorites[index],
                        index: index,
                        playlistModel:
                            PlaylistModel(tracks: favCubit.favorites),
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const PlayingTrack(),
    );
  }
}
