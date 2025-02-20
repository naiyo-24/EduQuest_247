import 'package:eduquest247/all_colleges.dart';

import 'package:eduquest247/colleges/fiem.dart';
import 'package:eduquest247/colleges/msit.dart';
import 'package:eduquest247/internships/app_dev.dart';
import 'package:eduquest247/internships/dig_market.dart';
import 'package:eduquest247/internships/graphics_design.dart'; // Import GraphicsPage
import 'package:eduquest247/internships/web_dev.dart';
 // Ensure this import is correct
import 'package:eduquest247/jobs_posted.dart';
import 'package:eduquest247/my_account.dart';
import 'package:eduquest247/news_feed.dart'; // Import NewsFeedPage
import 'package:eduquest247/notifications.dart';
import 'package:eduquest247/pages/reset_password.dart';
import 'package:eduquest247/post_jobs.dart';
import 'package:eduquest247/viewall_internships.dart';
import 'package:flutter/material.dart';
import 'package:eduquest247/pages/login.dart';
import 'package:eduquest247/pages/home_screen.dart';
import 'package:eduquest247/loans.dart';



import 'package:eduquest247/menu_bar.dart';
import 'package:eduquest247/scholarships/scholarship.dart';
import 'package:eduquest247/pages/splash.dart';
import 'package:get/get_navigation/src/routes/default_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../internships/network_market.dart'; // Import MenuBar
import 'package:eduquest247/internships/internship_form.dart';
import '../hr/hr_login_page.dart';

class Routes {
  static const String splash = '/'; // Changed to be the initial route
  static const String news = '/news_feed';
  static const String postjobs = '/post_jobs';
  static const String jobsposted = '/jobs_posted';
  static const String college = '/all_colleges';
  static const String login = '/login';
  static const String home = '/home';
  static const String jobs = '/job_posting';
  static const String loans = '/loans';
  static const String logout = '/logout';
  static const String chat = '/chat_boat';
  static const String myaccount = '/my_account';
  static const String iconaccount = '/icon_account';
  static const String internships = '/internships';
  static const String studentcounselling = '/studentcounselling';
  static const String studyabroad = '/study_abroad_page';
  static const String careerguidance = '/career_guidance';
  static const String careeercounselling = '/career_counselling';
  static const String notify = '/notifications';
  static const String settings = '/menu_bar'; // Add settings route
  static const String graphics = '/graphics_design'; // Add graphics route
  static const String network = '/network_market'; // Add graphics route
  static const String webdev = '/web_dev';
  static const String appdev = '/app_dev';
  static const String digmarket = '/dig_market';
  static const String fiem = 'fiem';
  static const String msit = 'msit';
  static const String allinternships = 'viewall_internships';
  static const String scholarship = '/scholarship';
  static const String internshipForm = '/internship_form';
  static const String viewAllInternships = '/viewall-internships';
  static const String jobApplication = '/job_application';
  static const String resetPassword = '/reset-password';
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return GetPageRoute(page: () => const SplashScreen());
      case '/home':
        return GetPageRoute(page: () => HomeScreen());
      case '/login':
        return GetPageRoute(page: () => const LoginPage());
      case Routes.iconaccount:
        return GetPageRoute(page: () => NewsFeedPage());
      case Routes.postjobs:
        return GetPageRoute(page: () => PostJobsPage());
      case Routes.jobsposted:
        return GetPageRoute(
          page: () => JobsPostedPage(),
          transition: Transition.fadeIn, // Add smooth transition
        );
      case Routes.news:
        return GetPageRoute(page: () => NewsFeedPage());
      case Routes.loans:
        return GetPageRoute(page: () => LoanPage());
   
      
      case Routes.college:
        return GetPageRoute(page: () => AllCollegesPage());
      
      case Routes.logout:
        return GetPageRoute(page: () => LoginPage());
     
      case Routes.notify:
        return GetPageRoute(page: () => NotificationsPage());
      case Routes.myaccount:
        return GetPageRoute(page: () => MyAccountPage());
      case Routes.settings:
        return GetPageRoute(page: () => StylishPage());
      
      case Routes.graphics:
        return GetPageRoute(page: () => GraphicsPage());
      case Routes.network:
        return GetPageRoute(page: () => NetworkPage());
      case Routes.webdev:
        return GetPageRoute(page: () => WebDevelopmentPage());
      case Routes.appdev:
        return GetPageRoute(page: () => AppDevelopmentPage());
      case Routes.digmarket:
        return GetPageRoute(page: () => DigitalMarketingPage());
      case Routes.allinternships:
        return GetPageRoute(page: () => ViewAllInternshipsPage());
      case Routes.fiem:
        return GetPageRoute(page: () => FIEMPage());
      case Routes.msit:
        return GetPageRoute(page: () => MSITPage());
      case Routes.scholarship:
        return GetPageRoute(page: () => ScholarshipPage());
      case Routes.internshipForm:
        if (args is String) {
          return GetPageRoute(
            page: () => Scaffold(
              body: InternshipApplicationForm(internshipType: args),
            ),
          );
        }
        return _errorRoute();
      case Routes.viewAllInternships:
        return GetPageRoute(
          page: () => ViewAllInternshipsPage(),
          transition: Transition.fadeIn,
        );
      case Routes.resetPassword:
        return GetPageRoute(
          page: () => const ResetPasswordPage(phone: 'Enter phone number',),
          transition: Transition.fadeIn,
        );
      case '/hr-login':
        return MaterialPageRoute(builder: (_) => HRLoginPage());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return GetPageRoute(
      page: () => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Page not found'),
        ),
      ),
    );
  }
}
