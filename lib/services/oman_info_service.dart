import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/omanInfoModel.dart';

class OmanInfoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'oman_info';

  // Get all Oman information
  Stream<List<OmanInfoModel>> getOmanInfo() {
    return _firestore
        .collection(_collection)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return OmanInfoModel.fromMap(doc.id, doc.data());
      }).toList();
    });
  }

  // Add initial data to Firestore
  Future<void> addInitialData() async {
    final List<Map<String, dynamic>> initialData = [
      {
        'title': 'Traditions',
        'description': 'Oman is known for its rich cultural traditions, including the traditional dance called Al-Razha and the use of incense in daily life.',
        'imageUrl': 'https://zrvcachteqbhgzbqknnf.supabase.co/storage/v1/object/public/almlahFiles/omaninfo/oman-tradition-askaladdin.webp',
      },
      {
        'title': 'Food',
        'description': 'Omani cuisine features dishes like Shuwa (slow-cooked lamb), Omani Halwa, and fresh seafood, reflecting the country\'s heritage.',
        'imageUrl': 'https://zrvcachteqbhgzbqknnf.supabase.co/storage/v1/object/public/almlahFiles/omaninfo/omanfood.webp',
      },
      {
        'title': 'Weather',
        'description': 'Oman has a hot desert climate with temperatures ranging from 20°C in winter to over 45°C in summer, especially in the interior.',
        'imageUrl': 'https://zrvcachteqbhgzbqknnf.supabase.co/storage/v1/object/public/almlahFiles/omaninfo/omanweeather.jpeg',
      },
      {
        'title': 'Uniform',
        'description': 'The traditional Omani attire includes the Dishdasha for men and the Hijab or Abaya for women, often adorned with cultural patterns.',
        'imageUrl': 'https://zrvcachteqbhgzbqknnf.supabase.co/storage/v1/object/public/almlahFiles/omaninfo/omanuniform.jpg',
      },
      {
        'title': 'Buildings',
        'description': 'Oman is famous for its forts like Nizwa Fort and modern architecture in Muscat, blending history with contemporary design.',
        'imageUrl': 'https://zrvcachteqbhgzbqknnf.supabase.co/storage/v1/object/public/almlahFiles/omaninfo/amazing-royal-opera-house.jpg',
      },
      {
        'title': 'History',
        'description': 'Oman has a history dating back to 2000 BCE, with influences from the maritime trade and the Al Said dynasty ruling since 1744.',
        'imageUrl': 'https://zrvcachteqbhgzbqknnf.supabase.co/storage/v1/object/public/almlahFiles/omaninfo/history.jpg',
      },
    ];

    // Check if collection is empty
    final QuerySnapshot snapshot = await _firestore.collection(_collection).get();
    if (snapshot.docs.isEmpty) {
      // Add all initial data
      for (var data in initialData) {
        await _firestore.collection(_collection).add(data);
      }
    }
  }
} 