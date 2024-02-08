import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'colors.dart';

final ThemeData lightTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    elevation: 0,
    scrolledUnderElevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle.dark,

    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.smallTextColor,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.white,
  ),
  scaffoldBackgroundColor: AppColors.scaffoldBackground,
  primaryColor: Colors.black,
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
      .copyWith(background: Colors.white),
);

final ThemeData darkTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    elevation: 0,
    scrolledUnderElevation: 0,
    color: AppColors.scaffoldBackground,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: const Color(0xff10151C),
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.grey[600],
  ),
  scaffoldBackgroundColor: AppColors.scaffoldBackground,
  primaryColor: const Color(0xff10151C),
  colorScheme:
      ColorScheme.fromSwatch().copyWith(background: const Color(0xff10151C)),
);

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.wave
    ..loadingStyle = EasyLoadingStyle.light
    ..indicatorSize = 35.0
    ..radius = 10.0
    ..userInteractions = false
    ..dismissOnTap = false;
}