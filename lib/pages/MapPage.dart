import 'package:flutter/material.dart';
import 'package:course_project/models/postModel.dart';
import 'package:course_project/pages/place_details.dart';

class MapPage extends StatefulWidget {
  final List<Postmodel> places;

  const MapPage({Key? key, required this.places}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  String? selectedGovernorate;
  String? selectedPlaceType;
  bool showOnlyWithImages = false;
  bool showFilter = true; // Boolean state to toggle filter visibility

  final List<String> governorates = [
    'Muscat', 'Dhofar', 'Musandam', 'Al Buraimi', 'Ad Dakhiliyah',
    'North Al Batinah', 'South Al Batinah', 'North Ash Sharqiyah',
    'South Ash Sharqiyah', 'Al Dhahirah', 'Al Wusta'
  ];

  final List<String> placeTypes = [
    'Beach', 'Wadi', 'Hot Spring', 'Mountain', 'Desert',
    'Castle', 'Fort', 'Museum', 'Cave', 'Park', 'Souq'
  ];

  List<Postmodel> get filteredPlaces {
    return widget.places.where((place) {
      final matchesGovernorate = selectedGovernorate == null || place.governorate == selectedGovernorate;
      final matchesPlaceType = selectedPlaceType == null || place.placeType == selectedPlaceType;
      final matchesImage = !showOnlyWithImages || (place.image != null && place.image!.isNotEmpty);
      return matchesGovernorate && matchesPlaceType && matchesImage;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Places')),
      body: Column(
        children: [
          // Button to toggle filter visibility
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  showFilter = !showFilter; // Toggle filter visibility
                });
              },
              child: Text(showFilter ? 'Hide Filter' : 'Show Filter'),
            ),
          ),

          // Filter Section (Visible only when showFilter is true)
          Visibility(
            visible: showFilter,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Dropdown for Governorate
                  DropdownButtonFormField<String>(
                    value: selectedGovernorate,
                    decoration: const InputDecoration(
                      labelText: 'Governorate',
                      border: OutlineInputBorder(),
                    ),
                    items: governorates.map((gov) {
                      return DropdownMenuItem(value: gov, child: Text(gov));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedGovernorate = value;
                      });
                    },
                  ),
                  const SizedBox(height: 12),

                  // Radio Buttons for Place Type
                  Wrap(
                    spacing: 10,
                    runSpacing: 6,
                    children: placeTypes.map((type) {
                      return ChoiceChip(
                        label: Text(type),
                        selected: selectedPlaceType == type,
                        onSelected: (selected) {
                          setState(() {
                            selectedPlaceType = selected ? type : null;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),

                  // Checkbox for image filtering
                  Row(
                    children: [
                      Checkbox(
                        value: showOnlyWithImages,
                        onChanged: (value) {
                          setState(() {
                            showOnlyWithImages = value ?? false;
                          });
                        },
                      ),
                      const Text('Show only places with images')
                    ],
                  ),
                ],
              ),
            ),
          ),

          const Divider(height: 1),

          // List of Places
          Expanded(
            child: filteredPlaces.isEmpty
                ? const Center(child: Text('No places match the filter.'))
                : ListView.builder(
                    itemCount: filteredPlaces.length,
                    itemBuilder: (context, index) {
                      final place = filteredPlaces[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlaceDetailScreen(place: place),
                            ),
                          );
                        },
                        child: Card(
                          margin: const EdgeInsets.all(10),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Center(
                                child: Image.asset(
                                  place.image ?? '',
                                  height: 180,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      place.placeName ?? 'Unnamed Place',
                                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(place.governorate ?? '', style: const TextStyle(color: Colors.grey)),
                                    const SizedBox(height: 8),
                                    Text(
                                      place.description ?? '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
