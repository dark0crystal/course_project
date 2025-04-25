import 'package:flutter/material.dart';
import 'package:course_project/models/postModel.dart';

class PlaceDetailScreen extends StatelessWidget {
  final Postmodel place;

  const PlaceDetailScreen({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(place.placeName ?? 'Place Details')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image(
                image:AssetImage(place.image ?? '')
                 ),
            ),
            SizedBox(height: 16),
            Text(
              place.placeName ?? '',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(place.governorate ?? '', style: TextStyle(color: Colors.grey)),
            SizedBox(height: 16),
            Text(place.description ?? '', style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            Text("Rating: ${place.rating ?? 'N/A'}", style: TextStyle(fontSize: 16)),
            Text("Type: ${place.placeType ?? 'Unknown'}", style: TextStyle(fontSize: 16)),
            Text("Location: ${place.location ?? 'Not Provided'}", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
