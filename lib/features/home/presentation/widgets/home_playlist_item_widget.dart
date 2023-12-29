import 'package:flutez/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../../../core/theming/assets.dart';
import '../../../../core/widgets/custom_texts.dart';

class HomePlayListItemWidget extends StatefulWidget {
  const HomePlayListItemWidget({super.key});

  @override
  State<HomePlayListItemWidget> createState() => _HomePlayListItemWidgetState();
}

class _HomePlayListItemWidgetState extends State<HomePlayListItemWidget> {
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
              borderRadius: BorderRadius.circular(15.r),
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
      ],
    );
  }
}
