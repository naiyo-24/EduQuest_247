import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

class NewsDetailPage extends StatelessWidget {
  final Map<String, String> article;

  const NewsDetailPage({Key? key, required this.article}) : super(key: key);

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
                    Color.fromARGB(252, 225, 224, 224),
                    Color.fromARGB(252, 225, 224, 224),
                    Color.fromARGB(252, 225, 224, 224),
                  ],
                  stops: [0.0, 0.7, 1.0],
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
                                  Colors.black.withOpacity(0.9),
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
                          color: Colors.black.withOpacity(0.7),
                          shape: BoxShape.circle,
                        ),
                        child:
                            const Icon(Icons.arrow_back, color: Colors.white),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    actions: [
                      IconButton(
                        icon: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.share, color: Colors.white),
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
                        color: Colors.black.withOpacity(0.8),
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
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      'March 15, 2024',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white70,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  article["title"]!,
                                  style: GoogleFonts.poppins(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
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
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
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
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          '5 min read',
                                          style: GoogleFonts.poppins(
                                            color: Colors.white70,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  article["description"]!,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    height: 1.8,
                                    color: Colors.white,
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
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              minimumSize: const Size(double.infinity, 50),
            ),
            icon: const Icon(Icons.bookmark_border, color: Colors.white),
            label: Text(
              'Save for later',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
