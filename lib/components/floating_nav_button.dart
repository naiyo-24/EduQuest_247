import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../pages/home_screen.dart';
import '../loans.dart';
import '../viewall_internships.dart';
import '../jobs_posted.dart';

class FloatingNavButton extends StatelessWidget {
  final int currentIndex;

  const FloatingNavButton({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9, // 90% of screen width
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom + 16,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white, // White background
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(0, Icons.home, 'Home'),
            _buildNavItem(1, Icons.account_balance_wallet, 'Borrow'),
            _buildNavItem(2, Icons.work, 'Internship'),
            _buildNavItem(3, Icons.business_center, 'Jobs'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = index == currentIndex;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        onTap: () => _onItemTapped(index),
        borderRadius: BorderRadius.circular(25),
        child: Tooltip(
          message: label,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color.fromARGB(255, 76, 163, 239).withOpacity(0.2)
                  : Colors.white, // White background
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: const Color.fromARGB(255, 76, 163, 239), // Blue icons
                  size: isSelected ? 28 : 24,
                ),
                if (isSelected)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 76, 163, 239), // Blue indicator
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    if (index == currentIndex) return;

    switch (index) {
      case 0:
        Get.offAll(
          () => HomeScreen(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 50),
        );
        break;
      case 1:
        Get.to(
          () => LoanPage(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 50),
        );
        break;
      case 2:
        Get.to(
          () =>  ViewAllInternshipsPage(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 50),
        );
        break;
      case 3:
        Get.to(
          () => JobsPostedPage(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 50),
        );
        break;
    }
  }
}
