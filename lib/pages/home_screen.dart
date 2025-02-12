// ignore_for_file: unused_import

import 'package:eduquest247/all_colleges.dart';
import 'package:eduquest247/components/ReusableCarousel.dart';
import 'package:eduquest247/components/floating_nav_button.dart';
import 'package:eduquest247/hr/hr_login_page.dart';
import 'package:eduquest247/components/standard_app_bar.dart';

// ignore:

import 'package:eduquest247/jobs_posted.dart';
import 'package:eduquest247/loans.dart';
import 'package:eduquest247/my_account.dart';
import 'package:eduquest247/notifications.dart';
import 'package:eduquest247/pages/news_detail_page.dart';
// ignore:
import 'package:eduquest247/route/route_generator.dart';
import 'package:eduquest247/viewall_internships.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:confetti/confetti.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:eduquest247/post_jobs.dart';
import 'package:eduquest247/scholarships/scholarship.dart';
import 'package:eduquest247/components/app_bar_dropdown.dart';
import 'package:flutter/animation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _arrowAnimationController;
  late Animation<double> _arrowAnimation;
  final PageController _pageController = PageController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();

    _arrowAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _arrowAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_arrowAnimationController);

    if (newsArticles.isEmpty) {
      loadMoreArticles();
    }

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
              _pageController.position.maxScrollExtent - 500 &&
          !_isLoadingMore) {
        _loadMore();
      }
    });
  }

  void _loadMore() async {
    if (_isLoadingMore) return;

    setState(() {
      _isLoadingMore = true;
    });

    await Future.delayed(const Duration(milliseconds: 100));
    loadMoreArticles();

    setState(() {
      _isLoadingMore = false;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _arrowAnimationController.dispose();
    super.dispose();
  }

  static final confettiController =
      ConfettiController(duration: const Duration(seconds: 1));
  static final scrollController = ScrollController();
  static final collegeScrollController = ScrollController();
  static final RxBool isLoadingMore = false.obs;
  static final RxBool isLoadingMoreColleges = false.obs;
  static final RxInt selectedIndex = 0.obs;

  static final RxList<Map<String, String>> newsArticles =
      <Map<String, String>>[].obs;
  static int _currentArticleIndex = 0;

  static Map<String, String> _generateArticle(int index) {
    final images = [
      'assets/images/bg1.png',
      'assets/images/picture12.jpg',
      'assets/images/picture1234.jpg',
      'assets/images/college1.jpg'
      'assets/images/dig_market.jpg'
      'assets/images/profile.jpeg'
    ];

    final titles = [
      "AI Advancement in Education",
      "Global Economic Trends",
      "Technology Innovation",
      "Educational Reform",
      "Career Development",
      "Industry Updates"
    ];

    final descriptions = [
      "Exploring the latest developments in artificial intelligence and its impact on various sectors.",
      "Analyzing current market trends and their implications for future growth.",
      "Discovering breakthrough technologies that are reshaping our world.",
      "Understanding changes in educational systems worldwide.",
      "Finding new opportunities in the evolving job market.",
      "Keeping up with industry changes and innovations."
    ];

    return {
      "image": images[index % images.length],
      "title": "News Article ${index + 1}: ${titles[index % titles.length]}",
      "description":
          "This is article ${index + 1} of our comprehensive coverage. ${descriptions[index % descriptions.length]}",
    };
  }

  static void loadMoreArticles() {
    final batch = List.generate(
        10, (index) => _generateArticle(_currentArticleIndex + index));
    newsArticles.addAll(batch);
    _currentArticleIndex += 10;
  }

  static final RxList<Map<String, String>> colleges = [
    {
      "name": 'Future Institute of Engineering and Management',
      "package": 'Packages starting from \$40,000',
      "location": 'Kolkata, India',
      "description":
          'A premier institute offering a variety of engineering and management courses.',
    },
    {
      "name": 'Meghnad Saha Institute of Technology',
      "package": 'Packages starting from \$42,000',
      "location": 'Kolkata, India',
      "description":
          'Known for its excellent faculty and state-of-the-art infrastructure.',
    },
    // Add more initial colleges here
  ].obs;

  static void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static void loadMoreColleges() {
    if (!isLoadingMoreColleges.value) {
      isLoadingMoreColleges.value = true;
      Future.delayed(const Duration(seconds: 2), () {
        colleges.addAll([
          {
            "name": 'New College 1',
            "package": 'Packages starting from \$45,000',
            "location": 'City, Country',
          },
          // Add more colleges here
        ]);
        isLoadingMoreColleges.value = false;
      });
    }
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Get.offAll(
          () => HomeScreen(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 20),
        );
        break;
      case 1:
        Get.to(
          () => LoanPage(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 20),
        );
        break;
      case 2:
        Get.to(
          () => ViewAllInternshipsPage(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 20),
        );
        break;
      case 3:
        Get.to(
          () => JobsPostedPage(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 20),
        );
        break;
      case 4:
        Get.to(
          () => const PostJobsPage(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 20),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final appBarHeight = kToolbarHeight * 0.8;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final availableHeight = screenHeight - appBarHeight - statusBarHeight;

    return Scaffold(
      appBar: const StandardAppBar(color: Color.fromARGB(255, 255, 255, 255),),
      body: Stack(
        children: [
          Container(
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
            child: Column(
              children: [
                // Featured Updates Section
                SizedBox(
                  height: 77, // Match the carousel height exactly
                  width: double.infinity,
                  child: ReusableCarousel(
                    items: [
                      CarouselItem(
                        imageUrl: "https://i.ibb.co/RvxKsfW/combo.gif",
                        title: 'Special Offer! on KFC ',
                        description: 'Get 50% off on your first order.',
                        buttonText: 'Shop Now',
                        logoimageUrl:
                            "https://upload.wikimedia.org/wikipedia/sco/thumb/b/bf/KFC_logo.svg/1024px-KFC_logo.svg.png",
                        onPressed: () {
                          launchURL('https://www.kfc.com/');
                        },
                      ),
                      CarouselItem(
                        imageUrl: 'https://i.ibb.co/P1pm5ff/pancake.png',
                        title: 'Limited Time!',
                        description: 'Buy one, get one free.',
                        buttonText: 'Grab Deal',
                        logoimageUrl:
                            "https://upload.wikimedia.org/wikipedia/en/thumb/d/d3/Starbucks_Corporation_Logo_2011.svg/1200px-Starbucks_Corporation_Logo_2011.svg.png",
                        onPressed: () {
                          launchURL('https://www.starbucks.com/');
                        },
                      ),
                    ],
                    itemWidth: MediaQuery.of(context).size.width.toInt(),
                    itemHeight: 77,
                  ),
                ),

                // Add 5px gap
                const SizedBox(height: 1),

                // News Section - Rest of the space
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (index >= newsArticles.length - 1) {
                        _loadMore();
                      }
                      final article = newsArticles[index % newsArticles.length];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewsDetailPage(
                                article: article,
                              ),
                            ),
                          );
                        },
                        child: Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.zero,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Color.fromARGB(255, 253, 254, 254), Color(0xFF87CEEB)],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Image at the extreme top of the container with rounded corners
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                    ),
                                    child: Image.asset(
                                      article["image"]!,
                                      fit: BoxFit.cover,
                                      height: 200, // Adjust the height as needed
                                      width: double.infinity,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 16),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            FadeTransition(
                                              opacity: _arrowAnimation,
                                              child: const Icon(
                                                Icons.keyboard_arrow_up,
                                                color: Color.fromARGB(255, 0, 0, 0),
                                                size: 24,
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              'Swipe up for more',
                                              style: GoogleFonts.jaldi(
                                                fontSize: 16,
                                                color:
                                                    const Color.fromARGB(255, 0, 0, 0).withOpacity(0.8),
                                                letterSpacing: 0.5,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                article["title"]!,
                                                style: GoogleFonts.openSans(
                                                  fontSize: 34,
                                                  fontWeight: FontWeight.bold,
                                                  color: const Color.fromARGB(255, 0, 0, 0),
                                                ),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.share,
                                                  color: Color.fromARGB(255, 0, 0, 0)),
                                              onPressed: () {
                                                // Add share functionality
                                              },
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          article["description"]!,
                                          style: GoogleFonts.jaldi(
                                            fontSize: 20,
                                            color: const Color.fromARGB(255, 1, 1, 1).withOpacity(0.9),
                                            height: 1.5,
                                          ),
                                          maxLines: 4,
                                                overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 26),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const FloatingNavButton(currentIndex: 0),
        ],
      ),
    );
  }

  Widget _buildActionIcon(IconData icon, VoidCallback onPressed) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      child: IconButton(
        icon: Icon(
          icon,
          color: const Color.fromARGB(255, 0, 0, 0),
          size: 24, // Reduced from default 24
        ),
        padding: const EdgeInsets.all(8), // Reduced padding
        constraints: const BoxConstraints(
          minWidth: 32,
          minHeight: 32,
        ), // Smaller tap target
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2), // Reduced from 8
      padding: const EdgeInsets.symmetric(
          horizontal: 6, vertical: 4), // Reduced vertical padding from 8
      child: Row(
        children: [
          Text(
            title,
            style: GoogleFonts.openSans(
              color: const Color(0xFF333333),
              fontSize: 18, // Reduced from 18
              fontWeight: FontWeight.w700, // Changed to bold
              letterSpacing: 0.2, // Reduced from 0.3
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Spacer(),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedUpdates(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      child: ReusableCarousel(
        items: [
          CarouselItem(
            imageUrl: "https://i.ibb.co/RvxKsfW/combo.gif",
            title: 'Special Offer! on KFC ',
            description: 'Get 50% off on your first order.',
            buttonText: 'Shop Now',
            logoimageUrl:
                "https://upload.wikimedia.org/wikipedia/sco/thumb/b/bf/KFC_logo.svg/1024px-KFC_logo.svg.png",
            onPressed: () {
              launchURL('https://www.kfc.com/');
            },
          ),
          CarouselItem(
            imageUrl: 'https://i.ibb.co/P1pm5ff/pancake.png',
            title: 'Limited Time!',
            description: 'Buy one, get one free.',
            buttonText: 'Grab Deal',
            logoimageUrl:
                "https://upload.wikimedia.org/wikipedia/en/thumb/d/d3/Starbucks_Corporation_Logo_2011.svg/1200px-Starbucks_Corporation_Logo_2011.svg.png",
            onPressed: () {
              launchURL('https://www.starbucks.com/');
            },
          ),
          CarouselItem(
            imageUrl: 'https://i.ibb.co/7jfqXxB/webinar.png',
            title: 'Live Webinar: Career Growth',
            description: 'Join our live webinar on career growth strategies.',
            logoimageUrl:
                "https://upload.wikimedia.org/wikipedia/en/thumb/d/d3/Starbucks_Corporation_Logo_2011.svg/1200px-Starbucks_Corporation_Logo_2011.svg.png",
            onPressed: () {
              launchURL('https://www.webinar.com/');
            },
            buttonText: 'Register Now',
          ),
        ],
        itemWidth: MediaQuery.of(context).size.width.toInt(), // Full width
        itemHeight: 250,
      ),
    );
  }

  Widget _buildCollegeCard({
    required String name,
    required String package,
    required String location,
    required String description,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        color: Colors.white,
        margin: const EdgeInsets.only(bottom: 16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: GoogleFonts.openSans(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                package,
                style: GoogleFonts.openSans(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                location,
                style: GoogleFonts.openSans(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: GoogleFonts.openSans(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implement your search results here
    return Center(
      child: Text('Search results for: $query', selectionColor: Color.fromARGB(0, 0, 0, 0),),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Implement your search suggestions here
    return Center(
      child: Text('Type to search colleges, courses...', selectionColor: Color.fromARGB(0, 0, 0, 0),),
    );
  }
}
