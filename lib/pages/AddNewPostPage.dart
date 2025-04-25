import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

  File? _selectedImage;

  @override
  void dispose() {
    _placeNameController.dispose();
    _placeDescriptionController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  void handleSubmit() {
    final name = _placeNameController.text.trim();
    final description = _placeDescriptionController.text.trim();
    final latitude = _latitudeController.text.trim();
    final longitude = _longitudeController.text.trim();

    if (name.isEmpty ||
        description.isEmpty ||
        latitude.isEmpty ||
        longitude.isEmpty ||
        selectedGovernorate == null ||
        selectedPlaceType == null ||
        _selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields and select an image.")),
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

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Post submitted successfully!")),
      );

      _placeNameController.clear();
      _placeDescriptionController.clear();
      _latitudeController.clear();
      _longitudeController.clear();
      setState(() {
        selectedGovernorate = null;
        selectedPlaceType = null;
        _selectedImage = null;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter valid numbers for latitude and longitude.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: "Latitude",
                      prefixIcon: Icon(Icons.location_on),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _longitudeController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: "Longitude",
                      prefixIcon: Icon(Icons.location_on),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: "Choose a Governorate:",
                border: OutlineInputBorder(),
              ),
              value: selectedGovernorate,
              items: Governorates.map((String governorate) {
                return DropdownMenuItem(
                  value: governorate,
                  child: Text(governorate),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedGovernorate = newValue;
                });
              },
            ),
            const SizedBox(height: 24),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: "Choose a Place Type:",
                border: OutlineInputBorder(),
              ),
              value: selectedPlaceType,
              items: PlaceTypes.map((String placeType) {
                return DropdownMenuItem(
                  value: placeType,
                  child: Text(placeType),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedPlaceType = newValue;
                });
              },
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: _pickImage,
              child: _selectedImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        _selectedImage!,
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'Tap to upload an image',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: handleSubmit,
              icon: const Icon(Icons.send),
              label: const Text("Submit"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
