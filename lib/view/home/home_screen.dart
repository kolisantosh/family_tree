import 'package:family_tree/configs/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../configs/Icon/icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const SizedBox(height: 20),

                // Title
                Row(
                  mainAxisSize: MainAxisSize.max,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Image.asset(AppIcons.search),
                    // SizedBox(width: 20),
                    Text(
                      AppLocalizations.of(context)!.homeStart, // Localized text for "Get Started"
                      textAlign: TextAlign.left,
                      style: Theme.of(
                        context,
                      ).textTheme.headlineLarge?.copyWith(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    SizedBox(width: 6),

                    Image.asset(AppIcons.search, height: 30, width: 30),
                  ],
                ),

                const SizedBox(height: 20),

                // Subtitle
                // Text(
                //   AppLocalizations.of(context)!.homeSub, // Localized text for "Get Started"
                //   textAlign: TextAlign.center,
                //   style: TextStyle(fontSize: 16, color: Colors.grey[600], fontFamily: "Poppins", fontStyle: FontStyle.italic),
                // ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    // boxShadow: [BoxShadow(color: Colors.grey.shade400, blurRadius: 5, spreadRadius: 0.8)],
                    border: Border.all(color: Colors.grey),
                  ),
                  child: ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.asset(AppIcons.banner1, fit: BoxFit.cover)),
                ),
                const SizedBox(height: 30),

                InkWell(
                  onTap: () {
                    // Navigate to search screen or perform search action
                    Navigator.pushNamed(context, RoutesName.member);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 2),
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    height: 50,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      boxShadow: [BoxShadow(color: Colors.grey.shade400, blurRadius: 5, spreadRadius: 0.8)],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search_rounded, color: Colors.black, size: 24),
                        SizedBox(width: 10),
                        Text(
                          AppLocalizations.of(context)!.search,
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),

                // Subtitle
                const SizedBox(height: 20),
                Text(
                  AppLocalizations.of(context)!.homeThought, // Localized text for "Get Started"
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                const SizedBox(height: 5),

                Text(
                  AppLocalizations.of(context)!.homeSub, // Localized text for "Get Started"
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontSize: 16,
                    color: Colors.grey[600],
                    fontFamily: "Poppins",
                    fontStyle: FontStyle.italic,
                  ),
                ),

                // Spacer(),
                const SizedBox(height: 30),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    // boxShadow: [BoxShadow(color: Colors.grey.shade400, blurRadius: 5, spreadRadius: 0.8)],
                    border: Border.all(color: Colors.grey),
                  ),
                  child: ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.asset(AppIcons.banner2, fit: BoxFit.cover)),
                ),
                const SizedBox(height: 20),

                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    margin: EdgeInsets.all(1),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      // boxShadow: [BoxShadow(color: Colors.grey.shade400, blurRadius: 5, spreadRadius: 0.8)],
                      border: Border.all(color: Colors.grey),
                      color: Colors.grey.shade300,
                      image: DecorationImage(image: AssetImage(AppIcons.tree), alignment: Alignment.center, fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.homeDetail, // Localized text for "Get Started"
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 16, color: Colors.grey[600], fontFamily: "Poppins"),
                    ),
                  ),
                ),

                // const SizedBox(height: 30),
                // Image.asset(AppIcons.banner2, fit: BoxFit.cover),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
