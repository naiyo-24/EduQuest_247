import 'package:eduquest247/all_colleges.dart';
import 'package:eduquest247/notifications.dart';
import 'package:eduquest247/pages/login.dart';
import 'package:eduquest247/scholarships/scholarship.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../hr/hr_login_page.dart';
import '../my_account.dart';
import 'app_bar_dropdown.dart';

class StandardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const StandardAppBar({super.key, required Color color});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight * 0.8);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF87CEEB), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
      elevation: 0,
      titleSpacing: 8,
      title: Text(
        'EduQuest247',
        style: GoogleFonts.jaldi(
          color: Colors.black,
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Colors.black, size: 20),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(maxWidth: 32),
          onPressed: () {
            showSearch(context: context, delegate: CustomSearchDelegate());
          },
        ),
        IconButton(
          icon: const Icon(Icons.business_center_outlined,
              color: Colors.black, size: 20),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(maxWidth: 32),
          onPressed: () => Get.to(
            () => HRLoginPage(),
            transition: Transition.fadeIn,
            duration: const Duration(milliseconds: 50),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.person_outline, color: Colors.black, size: 20),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(maxWidth: 32),
          onPressed: () => Get.to(
            () => const MyAccountPage(),
            transition: Transition.fadeIn,
            duration: const Duration(milliseconds: 50),
          ),
          
        ),
        const AppBarDropdown(showMyAccount: true),
        const SizedBox(width: 8),
      ],
    );
  }
}

class CustomSearchDelegate extends SearchDelegate<String> {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        titleTextStyle: GoogleFonts.jaldi(
          color: Colors.black87,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: GoogleFonts.jaldi(
          color: const Color.fromARGB(255, 0, 0, 0),
          fontSize: 18,
        ),
        border: InputBorder.none,
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      AnimatedOpacity(
        opacity: query.isNotEmpty ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 50),
        child: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query = '',
        ),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () => close(context, ''),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // This is where you'll implement the search results
    return Container(
      color: Colors.white,
      child: Center(
        child: Text(
          'No results found for "$query"',
          style: GoogleFonts.jaldi(
            color: const Color.fromARGB(255, 0, 0, 0),
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // This is where you'll implement search suggestions
    return Container(
      color: Colors.white,
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.history, color: Colors.grey),
            title: Text(
              'Suggestion $index',
              style: GoogleFonts.jaldi(
                color: Colors.black87,
                fontSize: 16,
              ),
            ),
            onTap: () {
              query = 'Suggestion $index';
              showResults(context);
            },
          );
        },
      ),
    );
  }
}

class AppBarDropdown extends StatelessWidget {
  final bool showMyAccount;

  const AppBarDropdown({super.key, required this.showMyAccount});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      icon: const Icon(Icons.more_vert, color: Colors.black),
      color: Colors.white.withOpacity(0.9), // Transparent white background
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Row(
            children: [
              const Icon(Icons.notifications, color: Color(0xFF87CEEB)), // Sky blue icon
              const SizedBox(width: 8),
              Text('Notifications', style: GoogleFonts.poppins(color: Colors.black)),
            ],
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Row(
            children: [
              const Icon(Icons.account_circle, color: Color(0xFF87CEEB)), // Sky blue icon
              const SizedBox(width: 8),
              Text('My Account', style: GoogleFonts.poppins(color: Colors.black)),
            ],
          ),
        ),
        PopupMenuItem(
          value: 3,
          child: Row(
            children: [
              const Icon(Icons.school, color: Color(0xFF87CEEB)), // Sky blue icon
              const SizedBox(width: 8),
              Text('Scholarship', style: GoogleFonts.poppins(color: Colors.black)),
            ],
          ),
        ),
        PopupMenuItem(
          value: 4,
          child: Row(
            children: [
              const Icon(Icons.list, color: Color(0xFF87CEEB)), // Sky blue icon
              const SizedBox(width: 8),
              Text('All Colleges', style: GoogleFonts.poppins(color: Colors.black)),
            ],
          ),
        ),
        PopupMenuItem(
          value: 5,
          child: Row(
            children: [
              const Icon(Icons.logout, color: Color(0xFF87CEEB)), // Sky blue icon
              const SizedBox(width: 8),
              Text('Logout', style: GoogleFonts.poppins(color: Colors.black)),
            ],
          ),
        ),
      ],
      onSelected: (value) {
        switch (value) {
          case 1:
            Get.to(() => const NotificationsPage());
            break;
          case 2:
            if (showMyAccount) {
              Get.to(() => const MyAccountPage());
            }
            break;
          case 3:
            Get.to(() => const ScholarshipPage());
            break;
          case 4:
            Get.to(() => AllCollegesPage());
            break;
          case 5:
            Get.to(() => const LoginPage());
            break;
        }
      },
    );
  }
}
