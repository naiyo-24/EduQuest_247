import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'internship_form.dart';
import 'package:eduquest247/components/standard_app_bar.dart';

class WebDevelopmentPage extends StatelessWidget {
  const WebDevelopmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StandardAppBar(color: Color.fromARGB(255, 255, 255, 255)),
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
