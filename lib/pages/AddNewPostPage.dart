import 'package:flutter/material.dart';

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
  final TextEditingController _governorateController = TextEditingController();
  final TextEditingController _placeTypeController = TextEditingController();

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
  void dispose() {
    _placeNameController.dispose();
    _placeDescriptionController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    _governorateController.dispose();
    _placeTypeController.dispose();
    super.dispose();
  }

  void handleSubmit() {
    final name = _placeNameController.text.trim();
    final description = _placeDescriptionController.text.trim();
    final latitude = _latitudeController.text.trim();
    final longitude = _longitudeController.text.trim();

    // Validate that latitude and longitude are numbers
    if (name.isEmpty || description.isEmpty || latitude.isEmpty || longitude.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields.")),
      );
      return;
    }

    try {
      final lat = double.parse(latitude);
      final lon = double.parse(longitude);

      // Ensure valid latitude and longitude ranges
      if (lat < -90 || lat > 90 || lon < -180 || lon > 180) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter valid latitude and longitude.")),
        );
        return;
      }

      

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Post submitted successfully!")),
      );

      // Clear fields
      _placeNameController.clear();
      _placeDescriptionController.clear();
      _latitudeController.clear();
      _longitudeController.clear();
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
        title: Text("Add New Post"),
        centerTitle: true,
      ),
      body: Padding(
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
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
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
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
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
            Column(
              children: [
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
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
                Text(
                  selectedGovernorate == null
                      ? "No governorate selected"
                      : "Selected $selectedGovernorate",
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Column(
              children: [
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
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
                Text(
                  selectedPlaceType == null
                      ? "No place type selected"
                      : "Selected $selectedPlaceType",
                  style: const TextStyle(fontSize: 18),
                ),
              ],
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
