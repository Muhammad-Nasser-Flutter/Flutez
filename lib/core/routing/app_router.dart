import 'package:flutez/core/routing/routes.dart';
import 'package:flutez/features/home/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';


class AppRouter {
  Route generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    final arguments = settings.arguments;

    switch (settings.name) {
      // case Routes.loginScreen:
      //   return PageTransition(
      //     child: LoginScreen(),
      //     type: PageTransitionType.fade,
      //     alignment: Alignment.center,
      //     settings: settings,
      //   );
      // case Routes.registerScreen:
      //   return PageTransition(
      //     child: RegisterScreen(),
      //     type: PageTransitionType.fade,
      //     alignment: Alignment.center,
      //     settings: settings,
      //   );
      // case Routes.mainLayoutScreen:
      //   return PageTransition(
      //     child: BlocProvider(
      //       create: (context) => MainLayoutCubit(),
      //       child: const MainLayoutScreen(),
      //     ),
      //     type: PageTransitionType.fade,
      //     alignment: Alignment.center,
      //     settings: settings,
      //   );
      // case Routes.onBoarding:
      //   return PageTransition(
      //     child: BlocProvider(
      //         create: (context) => OnBoardingCubit(),
      //         child: const OnBoardingScreen()),
      //     type: PageTransitionType.fade,
      //     alignment: Alignment.center,
      //     settings: settings,
      //   );
      case Routes.homeScreen:
        return PageTransition(
          child: const HomeScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          settings: settings,
        );
      // case Routes.notificationsScreen:
      //   return PageTransition(
      //     child: const NotificationsScreen(),
      //     type: PageTransitionType.fade,
      //     alignment: Alignment.center,
      //     settings: settings,
      //   );
      // case Routes.editProfile:
      //   return PageTransition(
      //     child: EditProfileScreen(),
      //     type: PageTransitionType.fade,
      //     alignment: Alignment.center,
      //     settings: settings,
      //   );
      // case Routes.bookRoom:
      //   return PageTransition(
      //     child: BlocProvider(
      //       create: (context) => BookCubit(),
      //       child: BookRoomScreen(),
      //     ),
      //     type: PageTransitionType.fade,
      //     alignment: Alignment.center,
      //     settings: settings,
      //   );
      default:
        return PageTransition(
          child: Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          settings: settings,
        );
    }
  }

  // List<Widget> screens = [
  //   BlocProvider(
  //     create: (context) => HomeCubit(),
  //     child: HomeScreen(),
  //   ),
  //   CurrentSurgeriesScreen(),
  //   PastSurgeriesScreen(),
  //   const ProfileScreen(),
  // ];
}
