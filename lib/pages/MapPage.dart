import 'package:course_project/pages/place_details.dart';
import 'package:flutter/material.dart';
import 'package:course_project/models/postModel.dart';

class MapPage extends StatelessWidget {
  final List<Postmodel> places;

  const MapPage({Key? key, required this.places}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Places')),
      body: ListView.builder(
        itemCount: places.length,
        itemBuilder: (context, index) {
          final place = places[index];
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
              margin: EdgeInsets.all(10),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Image.asset(
                  place.image ?? 'assets/oman1.jpg', // صورة بديلة في حال كانت null
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          place.placeName ?? 'Unnamed Place',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(place.governorate ?? '', style: TextStyle(color: Colors.grey)),
                        SizedBox(height: 8),
                        Text(place.description ?? '', maxLines: 2, overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
