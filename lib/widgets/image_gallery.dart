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
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: images.map((image) => Container(
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
        )).toList(),
      ),
    );
  }
} 