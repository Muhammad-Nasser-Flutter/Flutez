import 'package:flutez/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class Text12 extends StatelessWidget {
  int? maxLines;
  double? size;
  Color? textColor;
  double? height;
  double? spacing;
  String? family;
  TextOverflow? overFlow;
  TextAlign? alignment;
  FontWeight? weight;
  TextDecorationStyle? decorationStyle;
  TextDecoration? decoration;
  Color? decorationColor;
  double? decorationThickness;

  Text12({
    super.key,
    required this.text,
    this.textColor,
    this.size,
    this.overFlow,
    this.height,
    this.family,
    this.decorationStyle,
    this.alignment,
    this.weight,
    this.maxLines,
    this.spacing,
    this.decoration,
    this.decorationColor,
    this.decorationThickness,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size ?? 12.sp,
        fontWeight: weight ?? FontWeight.w400,
        color: textColor ??AppColors.smallTextColor,
            // (Theme.of(context).brightness == Brightness.light
            //     ? Colors.black
            //     : Colors.white),
        height: height,
        fontFamily: family ?? 'Montserrat',
        letterSpacing: spacing,
        decorationStyle: decorationStyle,
        decorationColor: decorationColor,
        decoration: decoration,
        decorationThickness: decorationThickness,
      ),
      textAlign: alignment,
      overflow: overFlow,
      maxLines: maxLines,
    );
  }
}
class Text14 extends StatelessWidget {
  int? maxLines;
  double? size;
  Color? textColor;
  double? height;
  double? spacing;
  String? family;
  TextOverflow? overFlow;
  TextAlign? alignment;
  FontWeight? weight;
  TextDecorationStyle? decorationStyle;
  TextDecoration? decoration;
  Color? decorationColor;
  double? decorationThickness;

  Text14({
    super.key,
    required this.text,
    this.textColor,
    this.size,
    this.overFlow,
    this.height,
    this.family,
    this.decorationStyle,
    this.alignment,
    this.weight,
    this.maxLines,
    this.spacing,
    this.decoration,
    this.decorationColor,
    this.decorationThickness,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size ?? 14.sp,
        fontWeight: weight ?? FontWeight.w500,
        color: textColor ??AppColors.smallTextColor,
            // (Theme.of(context).brightness == Brightness.light
            //     ? Colors.black
            //     : Colors.white),
        height: height,
        fontFamily: family ?? 'Montserrat',
        letterSpacing: spacing,
        decorationStyle: decorationStyle,
        decorationColor: decorationColor,
        decoration: decoration,
        decorationThickness: decorationThickness,
      ),
      textAlign: alignment,
      overflow: overFlow,
      maxLines: maxLines,
    );
  }
}

class Text16 extends StatelessWidget {
  int? maxLines;
  double? size;
  Color? textColor;
  double? height;
  double? spacing;
  String? family;
  TextOverflow? overFlow;
  TextAlign? alignment;
  FontWeight? weight;
  TextDecorationStyle? decorationStyle;
  Text16({
    super.key,
    required this.text,
    this.textColor,
    this.size,
    this.overFlow,
    this.height,
    this.family,
    this.decorationStyle,
    this.alignment,
    this.weight,
    this.maxLines,
    this.spacing,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      softWrap: true,
      text,
      style: TextStyle(
        fontSize: size ?? 16.sp,
        fontWeight: weight ?? FontWeight.w500,
        color: textColor ??AppColors.smallTextColor,
            // (Theme.of(context).brightness == Brightness.light
            //     ? Colors.black
            //     : Colors.white),
        height: height,
        fontFamily: family ?? 'Montserrat',
        letterSpacing: spacing,
        decorationStyle: decorationStyle,
      ),
      textAlign: alignment,
      overflow: overFlow,
      maxLines: maxLines,
    );
  }
}

class Text18 extends StatelessWidget {
  int? maxLines;
  double? size;
  Color? textColor;
  double? height;
  double? spacing;
  String? family;
  TextOverflow? overFlow;
  TextAlign? alignment;
  FontWeight? weight;
  TextDecorationStyle? decorationStyle;
  Text18({
    super.key,
    required this.text,
    this.textColor,
    this.size,
    this.overFlow,
    this.height,
    this.family,
    this.decorationStyle,
    this.alignment,
    this.weight,
    this.maxLines,
    this.spacing,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size ?? 18.sp,
        fontWeight: weight ?? FontWeight.w500,
        color: textColor ??AppColors.bigTextColor,
            // (Theme.of(context).brightness == Brightness.light
            //     ? Colors.black
            //     : Colors.white),
        height: height,
        fontFamily: family ?? 'Montserrat',
        letterSpacing: spacing,
        decorationStyle: decorationStyle,
      ),
      textAlign: alignment,
      overflow: overFlow,
      maxLines: maxLines,
    );
  }
}

class Text20 extends StatelessWidget {
  int? maxLines;
  double? size;
  Color? textColor;
  double? height;
  double? spacing;
  String? family;
  TextOverflow? overFlow;
  TextAlign? alignment;
  FontWeight? weight;
  TextDecorationStyle? decorationStyle;
  Text20({
    super.key,
    required this.text,
    this.textColor,
    this.size,
    this.overFlow,
    this.height,
    this.family,
    this.decorationStyle,
    this.alignment,
    this.weight,
    this.maxLines,
    this.spacing,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size ?? 20.sp,
        fontWeight: weight ?? FontWeight.w500,
        color: textColor ??
            (Theme.of(context).brightness == Brightness.light
                ? AppColors.bigTextColor
                : Colors.white),
        height: height,
        fontFamily: family ?? 'Montserrat',
        letterSpacing: spacing,
        decorationStyle: decorationStyle,
      ),
      textAlign: alignment,
      overflow: overFlow,
      maxLines: maxLines,
    );
  }
}

class Text22 extends StatelessWidget {
  int? maxLines;
  double? size;
  Color? textColor;
  double? height;
  double? spacing;
  String? family;
  TextOverflow? overFlow;
  TextAlign? alignment;
  FontWeight? weight;
  TextDecorationStyle? decorationStyle;
  Text22({
    super.key,
    required this.text,
    this.textColor,
    this.size,
    this.overFlow,
    this.height,
    this.family,
    this.decorationStyle,
    this.alignment,
    this.weight,
    this.maxLines,
    this.spacing,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size ?? 22.sp,
        fontWeight: weight ?? FontWeight.w500,
        color: textColor ??AppColors.bigTextColor,
            // (Theme.of(context).brightness == Brightness.light
            //     ? Colors.black
            //     : Colors.white),
        height: height,
        fontFamily: family ?? 'Gilroy',
        letterSpacing: spacing,
        decorationStyle: decorationStyle,
      ),
      textAlign: alignment,
      overflow: overFlow,
      maxLines: maxLines,
    );
  }
}

class Text24 extends StatelessWidget {
  int? maxLines;
  double? size;
  Color? textColor;
  double? height;
  double? spacing;
  String? family;
  TextOverflow? overFlow;
  TextAlign? alignment;
  FontWeight? weight;
  TextDecorationStyle? decorationStyle;
  Text24({
    super.key,
    required this.text,
    this.textColor,
    this.size,
    this.overFlow,
    this.height,
    this.family,
    this.decorationStyle,
    this.alignment,
    this.weight,
    this.maxLines,
    this.spacing,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size ?? 24.sp,
        fontWeight: weight ?? FontWeight.w500,
        color: textColor ??AppColors.bigTextColor,
            // (Theme.of(context).brightness == Brightness.light
            //     ? Colors.black
            //     : Colors.white),
        height: height,
        fontFamily: family ?? 'Montserrat',
        letterSpacing: spacing,
        decorationStyle: decorationStyle,
      ),
      textAlign: alignment,
      overflow: overFlow,
      maxLines: maxLines,
    );
  }
}

class Text26 extends StatelessWidget {
  int? maxLines;
  double? size;
  Color? textColor;
  double? height;
  double? spacing;
  String? family;
  TextOverflow? overFlow;
  TextAlign? alignment;
  FontWeight? weight;
  TextDecorationStyle? decorationStyle;
  Text26({
    super.key,
    required this.text,
    this.textColor,
    this.size,
    this.overFlow,
    this.height,
    this.family,
    this.decorationStyle,
    this.alignment,
    this.weight,
    this.maxLines,
    this.spacing,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size ?? 26.sp,
        fontWeight: weight ?? FontWeight.w500,
        color: textColor ??AppColors.bigTextColor,
            // (Theme.of(context).brightness == Brightness.light
            //     ? Colors.black
            //     : Colors.white),
        height: height,
        fontFamily: family ?? 'Montserrat',
        letterSpacing: spacing,
        decorationStyle: decorationStyle,
      ),
      textAlign: alignment,
      overflow: overFlow,
      maxLines: maxLines,
    );
  }
}

class Text28 extends StatelessWidget {
  int? maxLines;
  double? size;
  Color? textColor;
  double? height;
  double? spacing;
  String? family;
  TextOverflow? overFlow;
  TextAlign? alignment;
  FontWeight? weight;
  TextDecorationStyle? decorationStyle;
  Text28({
    super.key,
    required this.text,
    this.textColor,
    this.size,
    this.overFlow,
    this.height,
    this.family,
    this.decorationStyle,
    this.alignment,
    this.weight,
    this.maxLines,
    this.spacing,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size ?? 28.sp,
        fontWeight: weight ?? FontWeight.w500,
        color: textColor ??AppColors.bigTextColor,
            // (Theme.of(context).brightness == Brightness.light
            //     ? Colors.black
            //     : Colors.white),
        height: height,
        fontFamily: family ?? 'Montserrat',
        letterSpacing: spacing,
        decorationStyle: decorationStyle,
      ),
      textAlign: alignment,
      overflow: overFlow,
      maxLines: maxLines,
    );
  }
}
