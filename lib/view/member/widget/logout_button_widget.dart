import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Importing app localizations for translated text

import '../../../configs/routes/routes_name.dart'; // Importing the route names
import '../../../services/storage/local_storage.dart'; // Importing the LocalStorage class for managing local storage

/// A widget representing the logout button.
class LogoutButtonWidget extends StatelessWidget {
  const LogoutButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        LocalStorage localStorage = LocalStorage();
        localStorage.clearValue('token').then((value) {
          localStorage.clearValue('isLogin');
          Navigator.pushNamed(context, RoutesName.getStarted); // Navigating to the login screen after clearing token and isLogin value
        });
      },
      child: Center(
        child: Text(
          AppLocalizations.of(context)!.logout, // Localized text for logout button
        ),
      ),
    );
  }
}
