import 'package:flutez/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../../../core/theming/assets.dart';
import '../../../../core/widgets/custom_texts.dart';

class RecommendedItemWidget extends StatefulWidget {
  const RecommendedItemWidget({super.key});

  @override
  State<RecommendedItemWidget> createState() => _RecommendedItemWidgetState();
}

class _RecommendedItemWidgetState extends State<RecommendedItemWidget> {
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
    return Column(
      children: [
        Expanded(
          child: Container(
            width: 190.w,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: shadowColor ?? AppColors.scaffoldBackground,
                  blurRadius: 10.r,
                  spreadRadius: -5,
                  offset: const Offset(0, 20),
                ),
                BoxShadow(
                  color: shadowColor ?? AppColors.scaffoldBackground,
                  blurRadius: 10.r,
                  spreadRadius: -35,
                  offset: const Offset(0, 35),
                ),
              ],
              borderRadius: BorderRadius.circular(10.r),
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
  }
}
