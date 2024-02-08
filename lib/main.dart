import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutez/core/utilies/audio_init.dart';
import 'package:flutez/features/Profile/Bloc/profile_cubit.dart';
import 'package:flutez/features/Track/Bloc/track_cubit.dart';
import 'package:flutez/firebase_options.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/Api/my_dio.dart';
import 'core/bloc_observer.dart';
import 'core/cache_helper/cache_helper.dart';
import 'core/cache_helper/cache_values.dart';
import 'core/routing/app_router.dart';
import 'core/routing/routes.dart';
import 'core/theming/themes.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  Bloc.observer = MyBlocObserver();
  initAudio();
  configLoading();
  MyDio.init();
  if (kDebugMode) {
    print(
      "User Token : ${CacheHelper.getData(key: CacheKeys.uId)}",
    );
  }
  runApp(
    EasyLocalization(
      saveLocale: true,
      useFallbackTranslations: true,
      fallbackLocale: const Locale('en', 'UK'),
      supportedLocales: const [
        Locale('ar', 'EG'),
        Locale('en', 'UK'),
      ],
      path: 'assets/languages',
      child: MyApp(
        appRouter: AppRouter(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({super.key, required this.appRouter,});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context)=> TrackCubit()),
          BlocProvider(create: (context)=> ProfileCubit()..getProfileData()),
        ],
        child: MaterialApp(
          title: 'Flutez',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.dark,
          initialRoute:CacheHelper.isLoggedIn()? Routes.homeScreen:Routes.loginScreen,
          onGenerateRoute: appRouter.generateRoute,
          builder: EasyLoading.init(),
        ),
      ),
    );
  }
}
