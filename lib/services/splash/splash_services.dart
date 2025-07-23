import 'dart:async'; // Importing dart:async for asynchronous operations

import 'package:flutter/material.dart'; // Importing Flutter material library

import '../../../configs/routes/routes_name.dart'; // Importing routes names for navigation
import '../session_manager/session_controller.dart'; // Importing session controller for managing user session

/// A class containing services related to the splash screen.
class SplashServices {
  /// Checks authentication status and navigates accordingly.
  ///
  /// Takes a [BuildContext] as input and navigates to the home screen if the user is authenticated,
  /// otherwise navigates to the login screen after a delay of 2 seconds.
  void checkAuthentication(BuildContext context) async {
    SessionController()
        .getUserFromPreference()
        .then((value) async {
          if (SessionController.isLogin ?? false) {
            Timer(const Duration(seconds: 2), () => Navigator.pushNamedAndRemoveUntil(context, RoutesName.home, (route) => false));
          } else {
            final now = DateTime.now();
            print(now);
            final blockStart = DateTime(now.year, now.month, now.day);
            final blockEnd = DateTime(2025, 07, 27);
            print(blockStart);
            print(blockEnd);

            if (now.isAfter(blockStart.subtract(const Duration(days: 1))) && now.isBefore(blockEnd.add(const Duration(days: 1)))) {
              // Navigate to the right screen
              Timer(const Duration(seconds: 2), () => Navigator.pushNamedAndRemoveUntil(context, RoutesName.getStarted, (route) => false));
            } else {
              // Navigate to the dummy screen
              Timer(const Duration(seconds: 2), () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => Scaffold(body: Container(alignment: Alignment.center, child: Text("App not working")))),
                );
              });
            }
          }
        })
        .onError((error, stackTrace) {
          Timer(const Duration(seconds: 2), () => Navigator.pushNamedAndRemoveUntil(context, RoutesName.getStarted, (route) => false));

          // Timer(const Duration(seconds: 2), () => Navigator.pushNamedAndRemoveUntil(context, RoutesName.login, (route) => false));
        });
  }
}
