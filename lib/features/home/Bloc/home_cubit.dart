import 'package:flutez/core/theming/assets.dart';
import 'package:flutez/core/theming/colors.dart';
import 'package:flutez/features/home/Bloc/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palette_generator/palette_generator.dart';

class HomeCubit extends Cubit<HomeStates>{
  HomeCubit():super(HomeInitialState());
  static HomeCubit get(context) =>BlocProvider.of(context);


  PaletteGenerator? _paletteGenerator;
  List recommendedShadows = List.generate(10, (index) => AppColors.scaffoldBackground);
  List playlistShadows = List.generate(10, (index) => AppColors.scaffoldBackground);
  Future<void> updateRecommendedPaletteGenerator() async {
    // Replace 'your_image_path.jpg' with the actual path to your image
    const imageProvider = AssetImage(Assets.cover1);

    for (int i =0 ; i<10;i++){
      PaletteGenerator paletteGenerator =
      await PaletteGenerator.fromImageProvider(imageProvider);

      _paletteGenerator = paletteGenerator;
      recommendedShadows[i] = _paletteGenerator?.vibrantColor?.color.withOpacity(0.1);
    }
  }
  Future<void> updatePlaylistPaletteGenerator() async {
    // Replace 'your_image_path.jpg' with the actual path to your image
    const imageProvider = AssetImage(Assets.cover3);

    for (int i =0 ; i<10;i++){
      PaletteGenerator paletteGenerator =
      await PaletteGenerator.fromImageProvider(imageProvider);

      _paletteGenerator = paletteGenerator;
      playlistShadows[i] = _paletteGenerator?.vibrantColor?.color.withOpacity(0.1);
    }
  }

}