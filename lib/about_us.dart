import 'package:flutter/material.dart';

void main() {
  runApp(const EduQuestApp());
}

class EduQuestApp extends StatelessWidget {
  const EduQuestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 111, 53, 165),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
          bodyLarge: TextStyle(fontSize: 16, color: Colors.white),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 111, 53, 165),
          elevation: 0,
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 240, 240, 240),
      ),
      home: const AboutUsPage(),
    );
  }
}

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EduQuest247'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 111, 53, 165),
                    Color.fromARGB(255, 150, 100, 200),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Text(
                'About Us',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Text(
                        'Welcome to EduQuest247, your trusted partner in lifelong learning and academic excellence. We are dedicated to empowering students, educators, and knowledge seekers around the globe with innovative, accessible, and tailored educational solutions. Our mission is to provide high-quality educational resources and support to help individuals achieve their academic and professional goals. At EduQuest247, we believe that education is a lifelong journey, and we are here to guide you every step of the way.',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                          height: 1.6, // Line height for better readability
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Image.asset(
                          'assets/images/edulogo.jpg', // Replace with your image path
                          height: 500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
