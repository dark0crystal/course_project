import 'package:flutter/material.dart';

class ImageGallery extends StatelessWidget {
  const ImageGallery({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      'assets/images/oman1.jpeg',
      'assets/images/oman2.webp',
      'assets/images/oman3.jpeg',
      'assets/images/oman4.webp',
    ];

    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // Enable horizontal scrolling
        child: Row(
          children: images.map((image) => Row(
            children: [
              // Image container
              Container(
                width: 80,
                height: 80,
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Gray separator
              Container(
                width: 1,
                height: 80,
                color: Colors.grey, // Gray color separator
              ),
            ],
          )).toList(),
        ),
      ),
    );
  }
}
