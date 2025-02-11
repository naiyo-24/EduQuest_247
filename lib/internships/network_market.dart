import 'package:flutter/material.dart';
import 'internship_form.dart';
import 'package:google_fonts/google_fonts.dart';

class NetworkPage extends StatelessWidget {
  const NetworkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Network Marketing Internship',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 135, 206, 235), Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Color.fromARGB(255, 0, 0, 0),
              Colors.black,
            ],
            stops: [0.0, 0.7, 1.0],
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: InternshipApplicationForm(internshipType: 'Network Marketing'),
        ),
      ),
    );
  }
}
