import 'package:flutter/material.dart';

class TextCardScroller extends StatelessWidget {
  const TextCardScroller({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> texts = [
      'Tourism opens your mind to new cultures',
      'Discover hidden gems around the world',
      'Nature beauty awaits your adventure',
      'Every journey tells a unique story',
      'Explore, Dream, and create memories',
    ];

    return SizedBox(
      height: 80,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: texts.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 40,
                  color: Colors.grey.shade400,
                  margin: const EdgeInsets.only(right: 12),
                ),
                Text(
                  texts[index],
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
