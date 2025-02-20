// ignore_for_file: unnecessary_import

import 'package:eduquest247/internships/app_dev.dart';
import 'package:eduquest247/internships/dig_market.dart';
import 'package:eduquest247/internships/graphics_design.dart';
import 'package:eduquest247/internships/network_market.dart';
import 'package:eduquest247/internships/web_dev.dart';
import 'package:eduquest247/pages/splash.dart';
import 'package:eduquest247/route/route_generator.dart';
import 'package:eduquest247/pages/login.dart';
import 'package:eduquest247/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  runApp(const EduQuestApp());
}

class EduQuestApp extends StatelessWidget {
  const EduQuestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Eduquest247',
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => const SplashScreen(),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: '/login',
          page: () => const LoginPage(),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: '/home_screen',
          page: () => HomeScreen(),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: Routes.webdev,
          page: () => WebDevelopmentPage(),
        ),
        GetPage(
          name: Routes.network,
          page: () => NetworkPage(),
        ),
        GetPage(
          name: Routes.graphics,
          page: () => GraphicsPage(),
        ),
        GetPage(
          name: Routes.appdev,
          page: () => AppDevelopmentPage(),
        ),
        GetPage(
          name: Routes.digmarket,
          page: () => DigitalMarketingPage(),
        ),
      ],
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: ThemeData.light().copyWith(
        primaryColor: const Color(0xFF6A0DAD),
        scaffoldBackgroundColor: Colors.white,
        cardColor: Colors.white,
        textTheme: TextTheme(
          displayLarge: GoogleFonts.openSans(
            color: const Color(0xFF6A0DAD),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          headlineMedium: GoogleFonts.openSans(
            color: const Color(0xFF333333),
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          bodyLarge: GoogleFonts.openSans(
            color: const Color(0xFF333333),
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF6A0DAD),
          elevation: 0,
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF6A0DAD),
          secondary: const Color(0xFF9747FF),
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
