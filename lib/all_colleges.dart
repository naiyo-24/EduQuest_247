import 'package:eduquest247/colleges/fiem.dart';
import 'package:eduquest247/colleges/msit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'dart:ui';
import 'package:eduquest247/components/standard_app_bar.dart';


class AllCollegesPage extends StatelessWidget {
  final List<Map<String, dynamic>> colleges = [
    {
      'name': 'FIEM',
      'location': 'Kolkata, West Bengal',
      'courses': 'Engineering, Management',
      'image': 'assets/images/fiem.jpg',
      'onTap': () => Get.to(() => const FIEMPage()),
    },
    {
      'name': 'MSIT',
      'location': 'Kolkata, West Bengal',
      'courses': 'Engineering, Technology',
      'image': 'assets/images/msit.jpg',
      'onTap': () => Get.to(() => const MSITPage()),
    },
  ];

  AllCollegesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final appBarHeight = kToolbarHeight * 0.8;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final availableHeight = screenHeight - appBarHeight - statusBarHeight;

    return Scaffold(
      appBar: const StandardAppBar(
        color: Color.fromARGB(255, 246, 246, 246),
      ),
      body: Container(
        height: availableHeight,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Color.fromARGB(255, 135, 206, 235),
              Color.fromARGB(255, 135, 206, 235), // Sky blue color
            ],
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
          itemCount: colleges.length,
          itemBuilder: (context, index) {
            final college = colleges[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.white, // Changed from black
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1), // Reduced opacity
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Material(
                    color: Colors.white, // Changed from black with opacity
                    child: InkWell(
                      onTap: colleges[index]['onTap'],
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Hero(
                              tag: 'college_${colleges[index]['name']}',
                              child: Container(
                                height: 130,
                                width: 130,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 15,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                  image: DecorationImage(
                                    image: AssetImage(colleges[index]['image']),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    colleges[index]['name'],
                                    style: GoogleFonts.openSans(
                                      color: Colors.black, // Changed from white
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  _buildInfoRow(Icons.location_on_outlined,
                                      colleges[index]['location']),
                                  const SizedBox(height: 8),
                                  _buildInfoRow(Icons.school_outlined,
                                      colleges[index]['courses']),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildActionIcon(IconData icon, VoidCallback onPressed, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      child: IconButton(
        icon: Icon(icon, color: color, size: 24),
        padding: const EdgeInsets.all(8),
        constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.black), // Changed from white
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            text,
            style: GoogleFonts.openSans(
              color: Colors.black, // Changed from white
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}

class BackgroundPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..strokeWidth = 1;

    for (var i = 0; i < size.width; i += 20) {
      canvas.drawLine(Offset(i.toDouble(), 0), Offset(0, i.toDouble()), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
