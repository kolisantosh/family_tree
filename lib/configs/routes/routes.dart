import 'package:family_tree/configs/routes/routes_name.dart';
import 'package:flutter/material.dart';

import '../../model/movie_list/movie_list_model.dart';
import '../../view/views.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(builder: (BuildContext context) => const SplashView());

      case RoutesName.getStarted:
        return MaterialPageRoute(builder: (BuildContext context) => const GetStartedView());

      case RoutesName.home:
        return MaterialPageRoute(builder: (BuildContext context) => const MoviesScreen());

      case RoutesName.login:
        return MaterialPageRoute(builder: (BuildContext context) => const LoginScreen());

      case RoutesName.tree:
        return MaterialPageRoute(builder: (BuildContext context) => TreeView(args as TvShows));

      default:
        return MaterialPageRoute(
          builder: (_) {
            return const Scaffold(body: Center(child: Text('No route defined')));
          },
        );
    }
  }
}
