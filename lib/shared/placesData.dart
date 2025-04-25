

import 'package:course_project/models/postModel.dart';

List<Postmodel> Places = [
  Postmodel(
    id: "post1",
    userId: "user1",
    approval: true,
    placeName: "Al Qurum Park",
    location: "23.5917° N, 58.4447° E",
    description: "A beautiful public park located in Muscat with green spaces and walking trails.",
    rating: 5,
    governorate: "Muscat",
    placeType: "Park",
    image: "assets/oman1.jpeg",
  ),
  Postmodel(
    id: "post2",
    userId: "user2",
    approval: false,
    placeName: "Muttrah Souq",
    location: "23.6159° N, 58.5933° E",
    description: "One of the oldest markets in Oman offering traditional goods and spices.",
    rating: 4,
    governorate: "Muscat",
    placeType: "Market",
    image: "assets/oman2.jpeg",
  ),
];
