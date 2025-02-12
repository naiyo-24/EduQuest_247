// ignore: file_names
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusableCarousel extends StatelessWidget {
  final List<CarouselItem> items;

  const ReusableCarousel(
      {super.key,
      required this.items,
      required int itemWidth,
      required int itemHeight});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width; // Get screen width

    return CarouselSlider(
      options: CarouselOptions(
        height: 77, // Further reduced from 80
        enlargeCenterPage: false, // Changed to false
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        viewportFraction: 1.0, // Changed to full width
        padEnds: false, // Removes padding at the ends
      ),
      items: items.map((item) {
        return Container(
          width: screenWidth, // Ensure the container spans full width
          margin: const EdgeInsets.symmetric(
              horizontal: 0, vertical: 0), // Remove all margins
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: NetworkImage(item.imageUrl),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0), // Further reduced padding
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 6, // Further reduced logo size
                                  height: 8,
                                  margin: const EdgeInsets.only(right: 3),
                                  child: Image.network(
                                    item.logoimageUrl,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    item.title,
                                    style: GoogleFonts.openSans(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 1), // Minimal spacing
                            Text(
                              item.description,
                              style: GoogleFonts.openSans(
                                color: Colors.white70,
                                fontSize: 10,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 1), // Reduced from 4
                            SizedBox(
                              height: 16, // Further reduced button height
                              child: ElevatedButton(
                                onPressed: item.onPressed,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 0, 0, 0),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4), // Reduced from 8
                                  minimumSize:
                                      const Size(40, 16), // Reduced size
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text(
                                  item.buttonText,
                                  style: GoogleFonts.openSans(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 4), // Reduced from 8
                      ClipRRect(
                        borderRadius:
                            BorderRadius.circular(4), // Reduced from 8
                        child: Container(
                          width: 40, // Further reduced size
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(4),
                          child: Image.network(
                            item.logoimageUrl,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class CarouselItem {
  final String imageUrl;
  final String logoimageUrl;
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onPressed;

  CarouselItem({
    required this.imageUrl,
    required this.logoimageUrl,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onPressed,
  });
}
