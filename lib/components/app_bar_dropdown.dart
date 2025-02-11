import 'package:flutter/material.dart';
import 'package:eduquest247/notifications.dart';
import 'package:eduquest247/scholarships/scholarship.dart';
import 'package:eduquest247/menu_bar.dart';
import 'package:eduquest247/all_colleges.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarDropdown extends StatelessWidget {
  const AppBarDropdown({Key? key, required bool showMyAccount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        popupMenuTheme: PopupMenuThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 8,
          color: Colors.black,
        ),
      ),
      child: PopupMenuButton<String>(
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Icon(
                Icons.grid_view_rounded,
                color: Color.fromARGB(255, 0, 0, 0),
                size: 18,
              ),
            ],
          ),
        ),
        offset: const Offset(0, 50),
        itemBuilder: (BuildContext context) => [
          _buildAnimatedMenuItem(
            'notifications',
            Icons.notifications_outlined,
            'Notifications',
            'Check your updates',
          ),
          _buildAnimatedMenuItem(
            'scholarships',
            Icons.school_outlined,
            'Scholarships',
            'Find opportunities',
          ),
          _buildAnimatedMenuItem(
            'settings',
            Icons.settings_outlined,
            'Settings',
            'Customize your app',
          ),
          _buildAnimatedMenuItem(
            'colleges',
            Icons.account_balance_outlined,
            'Colleges',
            'Explore institutions',
          ),
        ],
        onSelected: (String value) {
          switch (value) {
            case 'notifications':
              Get.to(() => NotificationsPage(),
                  transition: Transition.fadeIn, 
                duration: const Duration(milliseconds: 50),
              );
            
              break;
            case 'scholarships':
              Get.to(() => ScholarshipPage(),
                  transition: Transition.fadeIn,
                   
                duration: const Duration(milliseconds: 50),
              );
            
              break;
            case 'settings':
              Get.to(() => StylishPage(),
                  transition: Transition.fadeIn, 
                duration: const Duration(milliseconds: 50),
              );
              break;
            case 'colleges':
              Get.to(() => AllCollegesPage(),
                  transition: Transition.fadeIn, 
                duration: const Duration(milliseconds: 50),
              );
              break;
          }
        },
      ),
    );
  }

  PopupMenuItem<String> _buildAnimatedMenuItem(
      String value, IconData icon, String title, String subtitle) {
    return PopupMenuItem<String>(
      value: value,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                size: 22,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
