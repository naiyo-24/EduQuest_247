import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'internship_form.dart';
import 'package:eduquest247/components/standard_app_bar.dart';

class GraphicsPage extends StatelessWidget {
  const GraphicsPage({super.key});

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
              Color.fromARGB(255, 0, 0, 0),
              Colors.black,
            ],
            stops: [0.0, 0.7, 1.0],
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: InternshipApplicationForm(internshipType: 'Graphics Design'),
        ),
      ),
    );
  }
}
