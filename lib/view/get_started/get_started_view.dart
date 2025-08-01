import 'package:family_tree/configs/Icon/icon.dart';
import 'package:family_tree/configs/themes/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../configs/routes/routes_name.dart';

class GetStartedView extends StatelessWidget {
  const GetStartedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            Image.asset(AppIcons.logo, height: 90, fit: BoxFit.cover),
            const SizedBox(height: 10),

            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                AppLocalizations.of(context)!.chatTitle, // Localized text for "Get Started"
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.headlineLarge?.copyWith(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
            ),

            const SizedBox(height: 10),

            // Subtitle
            Text(
              AppLocalizations.of(context)!.chatSubtitle, // Localized text for "Get Started"
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.displayLarge?.copyWith(fontSize: 16, color: Colors.grey[600], fontFamily: "Poppins", fontStyle: FontStyle.italic),
            ),
            const Spacer(),

            Image.asset(AppIcons.img, height: 400, fit: BoxFit.cover),

            const Spacer(),

            // Get Started Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context, RoutesName.home, (route) => false);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThemeConfig.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.getStarted, // Localized text for "Get Started"
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
