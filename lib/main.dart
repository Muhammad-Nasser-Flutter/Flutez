import 'package:firebase_core/firebase_core.dart';
import 'package:flutez/core/utilies/audio_init.dart';
import 'package:flutez/features/Downloads/Bloc/cubit/downloaded_tracks_cubit.dart';
import 'package:flutez/features/Profile/Bloc/profile_cubit.dart';
import 'package:flutez/features/Track/Bloc/track_cubit.dart';
import 'package:flutez/firebase_options.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/bloc_observer.dart';
import 'core/cache_helper/cache_helper.dart';
import 'core/cache_helper/cache_values.dart';
import 'core/routing/app_router.dart';
import 'core/routing/routes.dart';
import 'core/theming/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await CacheHelper.initializeConnction();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = MyBlocObserver();
  initAudio();
  configLoading();
  if (kDebugMode) {
    print(
      "User Token : ${CacheHelper.getData(key: CacheKeys.uId)}",
    );
  }
  runApp(
    MyApp(
      appRouter: AppRouter(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({
    super.key,
    required this.appRouter,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => TrackCubit()),
          BlocProvider(create: (context) => ProfileCubit()..getProfileData()),
          BlocProvider(create: (context) => DownloadedTracksCubit()..getDownloadedTracks()),
        ],
        child: MaterialApp(
          title: 'Flutez',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.dark,
          initialRoute: CacheHelper.isDesktop(context)
              ? Routes.desktopHomeScreen
              : CacheHelper.isLoggedIn()
                  ? CacheHelper.isOffline
                      ? Routes.downloadsScreen
                      : Routes.homeScreen
                  : Routes.loginScreen,
          onGenerateRoute: appRouter.generateRoute,
          builder: EasyLoading.init(),
        ),
      ),
    );
  }
}
