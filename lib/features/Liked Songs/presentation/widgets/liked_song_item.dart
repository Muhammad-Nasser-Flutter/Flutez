import 'package:flutez/core/helpers/extensions.dart';
import 'package:flutez/core/routing/routes.dart';
import 'package:flutez/core/theming/assets.dart';
import 'package:flutez/core/theming/colors.dart';
import 'package:flutez/core/widgets/custom_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palette_generator/palette_generator.dart';

class LikedSongItem extends StatefulWidget {
  const LikedSongItem({super.key});

  @override
  State<LikedSongItem> createState() => _LikedSongItemState();
}

class _LikedSongItemState extends State<LikedSongItem> {
  PaletteGenerator? _paletteGenerator;
  Color? shadowColor = Colors.grey.withOpacity(0.3);
  @override
  void initState() {
    super.initState();
    // Load your image here and get its dominant color
    _updatePaletteGenerator();
  }

  Future<void> _updatePaletteGenerator() async {
    // Replace 'your_image_path.jpg' with the actual path to your image
    const imageProvider = AssetImage(Assets.cover1);

    PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider);

    setState(() {
      _paletteGenerator = paletteGenerator;
      shadowColor = _paletteGenerator?.vibrantColor?.color.withOpacity(0.1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.pushNamed(Routes.playingNowScreen);
      },
      child: Column(
        children: [
          Expanded(
            child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              width: 190.w,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: shadowColor ?? AppColors.scaffoldBackground,
                    blurRadius: 15.r,
                    spreadRadius: -5,
                    offset: const Offset(0, 20),
                  ),
                ],
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: Image.asset(
                Assets.cover3,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text18(
            text: "Believer",
            weight: FontWeight.w500,
          ),
          SizedBox(
            height: 5.h,
          ),
          Text12(
            size: 13.sp,
            text: "Imagine Dragons",
            weight: FontWeight.w400,
          ),
        ],
      ),
    );
  }
}
