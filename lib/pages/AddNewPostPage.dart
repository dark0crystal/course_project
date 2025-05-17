import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:course_project/shared/auth_state.dart';
import 'package:course_project/services/post_service.dart';
import 'package:course_project/models/postModel.dart';
import 'package:course_project/pages/Login.dart';

class AddNewPostPage extends StatefulWidget {
  const AddNewPostPage({super.key});

  @override
  State<AddNewPostPage> createState() => _AddNewPostPageState();
}

class _AddNewPostPageState extends State<AddNewPostPage> {
  final TextEditingController _placeNameController = TextEditingController();
  final TextEditingController _placeDescriptionController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final PostService _postService = PostService();
  bool _isLoading = false;

  String? selectedGovernorate;
  final List<String> Governorates = [
    'Muscat',
    'Dhofar',
    'Musandam',
    'Al Buraimi',
    'Ad Dakhiliyah',
    'North Al Batinah',
    'South Al Batinah',
    'North Ash Sharqiyah',
    'South Ash Sharqiyah',
    'Al Dhahirah',
    'Al Wusta'
  ];

  String? selectedPlaceType;
  final List<String> PlaceTypes = [
    'Beach',
    'Wadi',
    'Hot Spring',
    'Mountain',
    'Desert',
    'Castle',
    'Fort',
    'Museum',
    'Cave',
    'Park',
    'Souq'
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authState = Provider.of<AuthState>(context, listen: false);
      if (!authState.isLoggedIn) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => Login()),
        );
      }
    });
  }

  @override
  void dispose() {
    _placeNameController.dispose();
    _placeDescriptionController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  Future<void> _submitPost() async {
    final authState = Provider.of<AuthState>(context, listen: false);
    if (!authState.isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => Login()),
      );
      return;
    }

    final name = _placeNameController.text.trim();
    final description = _placeDescriptionController.text.trim();
    final latitude = _latitudeController.text.trim();
    final longitude = _longitudeController.text.trim();
    final imageUrl = _imageUrlController.text.trim();

    if (name.isEmpty || description.isEmpty || latitude.isEmpty || longitude.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    if (selectedGovernorate == null || selectedPlaceType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select governorate and place type")),
      );
      return;
    }

    try {
      final lat = double.parse(latitude);
      final lon = double.parse(longitude);

      if (lat < -90 || lat > 90 || lon < -180 || lon > 180) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter valid latitude and longitude.")),
        );
        return;
      }

      setState(() {
        _isLoading = true;
      });

      final post = Postmodel(
        id: '',
        placeName: name,
        description: description,
        location: '$lat, $lon',
        governorate: selectedGovernorate!,
        placeType: selectedPlaceType!,
        rating: 5,
        approval: false,
        userId: authState.currentUser!.id,
        image: imageUrl.isEmpty ? null : imageUrl,
      );

      await _postService.createPost(post, authState.currentUser!.id);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Post submitted successfully!")),
        );

        _placeNameController.clear();
        _placeDescriptionController.clear();
        _latitudeController.clear();
        _longitudeController.clear();
        _imageUrlController.clear();
        setState(() {
          selectedGovernorate = null;
          selectedPlaceType = null;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${e.toString()}")),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = Provider.of<AuthState>(context);
    
    if (!authState.isLoggedIn) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Post"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _placeNameController,
              decoration: const InputDecoration(
                labelText: "Place Name",
                prefixIcon: Icon(Icons.place),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _placeDescriptionController,
              decoration: const InputDecoration(
                labelText: "Place Description",
                prefixIcon: Icon(Icons.description),
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _latitudeController,
                    decoration: const InputDecoration(
                      labelText: "Latitude",
                      prefixIcon: Icon(Icons.location_on),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _longitudeController,
                    decoration: const InputDecoration(
                      labelText: "Longitude",
                      prefixIcon: Icon(Icons.location_on),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            DropdownButtonFormField<String>(
              value: selectedGovernorate,
              decoration: const InputDecoration(
                labelText: "Governorate",
                prefixIcon: Icon(Icons.map),
                border: OutlineInputBorder(),
              ),
              items: Governorates.map((String governorate) {
                return DropdownMenuItem<String>(
                  value: governorate,
                  child: Text(governorate),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedGovernorate = newValue;
                });
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedPlaceType,
              decoration: const InputDecoration(
                labelText: "Place Type",
                prefixIcon: Icon(Icons.category),
                border: OutlineInputBorder(),
              ),
              items: PlaceTypes.map((String type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedPlaceType = newValue;
                });
              },
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _imageUrlController,
              decoration: const InputDecoration(
                labelText: "Image URL",
                prefixIcon: Icon(Icons.image),
                border: OutlineInputBorder(),
                hintText: "Paste the image URL here",
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _submitPost,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text("Submit Post"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
