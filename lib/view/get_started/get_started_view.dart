import 'package:family_tree/configs/themes/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../configs/routes/routes_name.dart';

class GetStartedView extends StatelessWidget {
  const GetStartedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // Illustration
              // SvgPicture.asset(
              //   'assets/chat_circle.svg', // Replace with your illustration
              //   height: 250,
              // ),
              const SizedBox(height: 40),

              // Title
              Text(
                AppLocalizations.of(context)!.chatTitle, // Localized text for "Get Started"
                textAlign: TextAlign.center,
                // style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87),
              ),

              const SizedBox(height: 16),

              // Subtitle
              Text(
                AppLocalizations.of(context)!.chatSubtitle, // Localized text for "Get Started"

                textAlign: TextAlign.center,
                // style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),

              const Spacer(),

              // Get Started Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context, RoutesName.home, (route) => false);

                    // Timer(const Duration(seconds: 2), () => Navigator.pushNamedAndRemoveUntil(context, RoutesName.login, (route) => false));
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

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
