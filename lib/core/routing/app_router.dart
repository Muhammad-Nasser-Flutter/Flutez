import 'package:flutez/core/routing/routes.dart';
import 'package:flutez/features/Auth/Bloc/Auth_cubit.dart';
import 'package:flutez/features/Favorites/Bloc/favorites_cubit.dart';
import 'package:flutez/features/Profile/presentation/profile_screen.dart';
import 'package:flutez/features/Search/Bloc/search_cubit.dart';
import 'package:flutez/features/Search/presentation/search_screen.dart';
import 'package:flutez/features/Track/presentation/playing_now_screen.dart';
import 'package:flutez/features/home/Bloc/home_cubit.dart';
import 'package:flutez/features/Playlists/models/playlist_model.dart';
import 'package:flutez/features/home/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import '../../features/Auth/presentation/Screens/login_screen.dart';
import '../../features/Auth/presentation/Screens/register_screen.dart';
import '../../features/Favorites/presentation/favorites_screen.dart';
import '../../features/Playlists/Presentation/playlist_tracks_screen.dart';
import '../../features/Track/Model/track_model.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.loginScreen:
        return PageTransition(
          child: BlocProvider(
            child: LoginScreen(),
            create: (context) => AuthCubit(),
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          settings: settings,
        );
      case Routes.registerScreen:
        return PageTransition(
          child: BlocProvider(
            child: RegisterScreen(),
            create: (context) => AuthCubit(),
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          settings: settings,
        );
      case Routes.homeScreen:
        return PageTransition(
          child: BlocProvider(
            child: const HomeScreen(),
            create: (context) => HomeCubit()
              ..getRecommendedTracks()
              ..getPlaylist(),
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          settings: settings,
        );
      case Routes.playlistTracks:
        return PageTransition(
          child:
              PlaylistTracksScreen(model: settings.arguments as PlaylistModel),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          settings: settings,
        );
      case Routes.likedSongs:
        return PageTransition(
          child: BlocProvider(
            create: (context) => FavoritesCubit()..getFavorites(),
            child: const FavoritesScreen(),
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          settings: settings,
        );
      case Routes.playingNowScreen:
        return PageTransition(
          child: PlayingNowScreen(
            track: settings.arguments as Track,
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          settings: settings,
        );
      case Routes.profile:
        return PageTransition(
          child: const ProfileScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          settings: settings,
        );
      case Routes.searchScreen:
        return PageTransition(
          child: BlocProvider(
              create: (BuildContext context) => SearchCubit(),
              child: SearchScreen()),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          settings: settings,
        );
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
