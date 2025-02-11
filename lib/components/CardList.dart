import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecommendedCardList extends StatelessWidget {
  final List<RecommendedItem> items;

  const RecommendedCardList({super.key, required this.items, required List<RecommendedItem> CHILDREN});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Container(
            width: MediaQuery.of(context).size.width * 0.45,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 5, 5, 5), // Purple background for the card
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 190, 190, 190).withOpacity(0.4), // Purple shadow
                  blurRadius: 8,
                  spreadRadius: 1,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image with rating overlay
                Stack(
                  children: [
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(item.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          color:
                          const Color.fromARGB(255, 145, 142, 145).withOpacity(0.8), // Purple overlay
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star,
                                color: Colors.yellow, size: 14), // Yellow star
                            const SizedBox(width: 4),
                            Text(
                              item.rating.toString(),
                              style: const TextStyle(
                                color: Colors.white, // White text
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // Content below image
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Dish Name
                      Text(
                        item.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.jaldi(
                          color: Colors.white, // White text
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Prep Time
                      Row(
                        children: [
                          const Icon(Icons.timer,
                              color: Colors.white70, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            '${item.prepTime} min',
                            style: const TextStyle(
                              color: Colors.white70, // Light white text
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Price and Add Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Price
                          Text(
                            '₹${item.price.toStringAsFixed(2)}',
                            style: GoogleFonts.jaldi(
                              color: Colors.white, // White text
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // Add Button
                          // ElevatedButton(
                          //   onPressed: () {
                          //     item.onAdd();
                          //   },
                          //   style: ElevatedButton.styleFrom(
                          //     shape: const CircleBorder(),
                          //     backgroundColor: Colors.white,
                          //     padding: const EdgeInsets.all(10),
                          //   ),
                          //   child: const Icon(Icons.add,
                          //       color: Colors.black, size: 26),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class RecommendedItem {
  final String name;
  final String imageUrl;
  final double rating;
  final int prepTime;
  final double price;
  final VoidCallback onAdd;

  RecommendedItem({
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.prepTime,
    required this.price,
    required this.onAdd, required Null Function() onpressed, required Null Function() onPressed,
  });
}
