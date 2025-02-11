import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'internship_form.dart';

class WebDevelopmentPage extends StatelessWidget {
  const WebDevelopmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Web Development Internship',
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
              Color.fromARGB(255, 135, 206, 235),
              Color.fromARGB(255, 252, 252, 252),
            ],
            stops: [0.0, 0.7, 1.0],
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              InternshipApplicationForm(internshipType: 'Web Development'),
            ],
          ),
        ),
      ),
    );
  }
}
