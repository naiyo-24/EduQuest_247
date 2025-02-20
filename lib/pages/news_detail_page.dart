import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

class NewsDetailPage extends StatelessWidget {
  final Map<String, String> article;

  const NewsDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Color.fromARGB(255, 135, 206, 235), // Sky blue
                  ],
                  stops: [0.0, 1.0],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: CustomScrollView(
                physics: const ClampingScrollPhysics(), // Prevent overscroll
                slivers: [
                  SliverAppBar(
                    expandedHeight: 300,
                    floating: false,
                    pinned: true,
                    backgroundColor: Color.fromARGB(252, 225, 224, 224),
                    elevation: 0,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          Hero(
                            tag: 'newsImage${article["title"]}',
                            child: Image.asset(
                              article["image"]!,
                              fit: BoxFit.cover,
                            ),
                          ),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.transparent, // Remove the dark overlay
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    leading: IconButton(
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 250, 250, 250).withOpacity(0.7),
                          shape: BoxShape.circle,
                        ),
                        child:
                            const Icon(Icons.arrow_back, color: Color.fromARGB(255, 14, 77, 150)),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    actions: [
                      IconButton(
                        icon: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.7),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.share, color: Color.fromARGB(255, 14, 77, 150)),
                        ),
                        onPressed: () {
                          Share.share(
                              'Check out this article: ${article["title"]}');
                        },
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent, // Remove the dark background
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        'Education',
                                        style: GoogleFonts.openSans(
                                          color: Colors.black,
                                          fontSize: 14, // Adjusted text size
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      'March 15, 2024',
                                      style: GoogleFonts.openSans(
                                        color: Colors.black,
                                        fontSize: 14, // Adjusted text size
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  article["title"]!,
                                  style: GoogleFonts.openSans(
                                    fontSize: 24, // Adjusted text size
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    height: 1.3,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundColor:
                                          Colors.white.withOpacity(0.1),
                                      child: Text(
                                        'EQ',
                                        style: GoogleFonts.openSans(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'EduQuest Team',
                                          style: GoogleFonts.openSans(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18, // Adjusted text size
                                          ),
                                        ),
                                        Text(
                                          '5 min read',
                                          style: GoogleFonts.openSans(
                                            color: Colors.black54,
                                            fontSize: 10, // Adjusted text size
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  article["description"]!,
                                  style: GoogleFonts.openSans(
                                    fontSize: 18, // Adjusted text size
                                    height: 1.8,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 253, 253, 253),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              minimumSize: const Size(double.infinity, 50),
            ),
            icon: const Icon(Icons.bookmark_border, color: Color.fromARGB(255, 14, 77, 150)),
            label: Text(
              'Save for later',
              style: GoogleFonts.openSans(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16, // Adjusted text size
              ),
            ),
          ),
        ],
      ),
    );
  }
}