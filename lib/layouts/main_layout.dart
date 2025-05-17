import 'package:flutter/material.dart';
import 'package:course_project/pages/About.dart';
import 'package:course_project/pages/MapPage.dart';
import 'package:course_project/pages/OmanInfoPage.dart';
import 'package:course_project/widgets/navbar.dart';
import 'package:course_project/widgets/hero_section.dart';
import 'package:course_project/widgets/image_gallery.dart';
import 'package:course_project/widgets/TextCardScroller.dart';
import 'package:course_project/widgets/action_section.dart';
import 'package:course_project/widgets/footer.dart';
import 'package:course_project/models/postModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late TabController _tabController;
  List<Postmodel> _places = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildHomePage() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Navbar(),
          SizedBox(height: 40),
          HeroSection(),
          SizedBox(height: 20),
          Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(
                'Explore More',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          SizedBox(height: 40),
          ImageGallery(),
          SizedBox(height: 40),
          TextCardScroller(),
          SizedBox(height: 40),
          ActionSection(),
          SizedBox(height: 40),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Footer(),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildTabView() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    
    return TabBarView(
      controller: _tabController,
      children: [
        _buildHomePage(),
        const MapPage(),
        OmanInfoPage(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildTabView(),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                setState(() {
                  _selectedIndex = 0;
                  _tabController.animateTo(0);
                });
              },
              color: _selectedIndex == 0 ? Colors.teal : Colors.grey,
            ),
            IconButton(
              icon: const Icon(Icons.map),
              onPressed: () {
                setState(() {
                  _selectedIndex = 1;
                  _tabController.animateTo(1);
                });
              },
              color: _selectedIndex == 1 ? Colors.teal : Colors.grey,
            ),
            IconButton(
              icon: const Icon(Icons.info),
              onPressed: () {
                setState(() {
                  _selectedIndex = 2;
                  _tabController.animateTo(2);
                });
              },
              color: _selectedIndex == 2 ? Colors.teal : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}