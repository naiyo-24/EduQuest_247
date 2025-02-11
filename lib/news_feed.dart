import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NewsFeedPage(),
    );
  }
}

class NewsFeedPage extends StatefulWidget {
  final Map<String, String>? selectedArticle;

  NewsFeedPage({this.selectedArticle});

  @override
  _NewsFeedPageState createState() => _NewsFeedPageState();
}

class _NewsFeedPageState extends State<NewsFeedPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Sample data for news articles
  final List<Map<String, String>> _newsArticles = [
    {
      "title":
      "Singapore's declining fertility rates signal an economic concern",
      "description":
      "Elon Musk, often in the news for futuristic ideas, recently addressed Singapore's fertility rates. This raises questions about economic sustainability...",
      "image": 'assets/images/pic1234.png',
    },
    {
      "title": "Global warming: How it impacts the food industry",
      "description":
      "Climate change is causing significant shifts in agricultural patterns. Here's what you need to know about its effect on global food supply...",
      "image": 'assets/images/global_warming.png',
    },
    {
      "title": "AI revolution: Transforming industries in 2024",
      "description":
      "AI continues to disrupt traditional industries. Here's a closer look at how AI advancements are reshaping the future of work...",
      "image": 'assets/images/ai_revolution.png',
    },
    {
      "title": "Top Universities Announce New Online Programs",
      "description":
      "Leading institutions expand their digital learning offerings.",
      "image": 'assets/images/online_learning.jpg',
    },
    // Add more articles here
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 2, vsync: this); // Adjust the tab length as needed
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF6A0DAD),
        elevation: 0,
        title: Text(
          "News to stay updated with",
          style: GoogleFonts.jaldi(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: [
            const Tab(text: "Latest News"),
            const Tab(text: "Trending Topics"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          widget.selectedArticle != null
              ? _buildSelectedArticle(widget.selectedArticle!)
              : _buildNewsList(),
          Center(
              child: Text("Trending Topics", style: TextStyle(fontSize: 18))),
        ],
      ),
    );
  }

  Widget _buildSelectedArticle(Map<String, String> article) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            article["image"]!,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 16),
          Text(
            article["title"]!,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            article["description"]!,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: _newsArticles.length,
      itemBuilder: (context, index) {
        final article = _newsArticles[index];
        return _buildNewsCard(
          title: article["title"]!,
          description: article["description"]!,
          image: article["image"]!,
        );
      },
    );
  }

  Widget _buildNewsCard({
    required String title,
    required String description,
    required String image,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
              const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                image,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: Center(
                      child: Icon(Icons.broken_image,
                          size: 50, color: Colors.grey[700]),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
