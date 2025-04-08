import 'package:flutter/material.dart';

class ImageGallery extends StatelessWidget {
  const ImageGallery({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      'assets/oman1.jpeg',
      'assets/oman2.webp',
      'assets/oman3.jpeg',
      'assets/oman4.webp',
    ];

    return Container(
      height: 150,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: images.map((image) => Container(
            width: 120,
            height: 120,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    width: 2, // Width of the grey line
                    color: Colors.grey[400], // Grey color for the separator
                  ),
                ),
              ],
            ),
          )).toList(),
        ),
      ),
    );
  }
}