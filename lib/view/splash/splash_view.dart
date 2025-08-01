import 'package:flutter/material.dart';

import '../../configs/Icon/icon.dart';
import '../../services/splash/splash_services.dart'; // Importing the SplashServices class from the services/splash/splash_services.dart file

/// A widget representing the splash screen of the application.
class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

/// The state of the [SplashView] widget.
class _SplashViewState extends State<SplashView> {
  final SplashServices splashServices = SplashServices(); // Instance of SplashServices for handling splash screen logic

  @override
  void initState() {
    super.initState();
    // Calls the [checkAuthentication] method from [SplashServices] to handle authentication logic
    splashServices.checkAuthentication(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Sets the background color of the splash screen
      body: Center(
        child: Image.asset(AppIcons.logo, height: 150),
        // child: Text(
        //   // Displays the localized text for the splash screen
        //   AppLocalizations.of(context)!.splashScreen,
        //   style: Theme.of(context).textTheme.displayMedium, // Applies the displayMedium text style from the current theme
        // ),
      ),
    );
  }
}
