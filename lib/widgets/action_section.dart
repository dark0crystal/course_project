import 'package:course_project/pages/MapPage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_project/models/postModel.dart';

class ActionSection extends StatefulWidget {
  const ActionSection({super.key});

  @override
  State<ActionSection> createState() => _ActionSectionState();
}

class _ActionSectionState extends State<ActionSection> {
  List<Postmodel> _places = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPlaces();
  }

  Future<void> _fetchPlaces() async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('posts')
          .where('approval', isEqualTo: true)
          .get();

      setState(() {
        _places = snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return Postmodel(
            id: doc.id,
            userId: data['userId'] ?? '',
            placeName: data['placeName'] ?? '',
            description: data['description'] ?? '',
            governorate: data['governorate'] ?? '',
            placeType: data['placeType'] ?? '',
            location: data['location'] ?? '',
            rating: (data['rating'] ?? 0).toInt(),
            approval: data['approval'] ?? false,
            image: data['image'] ?? '',
          );
        }).toList();
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching places: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          ElevatedButton.icon(
            onPressed: _isLoading 
              ? null 
              : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MapPage()),
                  );
                },
            icon: const Icon(Icons.map),
            label: Text(
              _isLoading ? 'Loading...' : 'Go To Map',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'We Cover ${_places.length} Tourism Places',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 2),
                const Text('🎉'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
