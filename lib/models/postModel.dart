// Place_name		string
// Location 		string  	
// Description             string 
// Rating		double
// Governorate		string
// Place_type		string
// Id 			string 
// User_id		string
// Approval		boolean

class Postmodel {
  final String id;
  String? placeName;
  String? description;
  String? location;
  String? governorate;
  String? placeType;
  int? rating;
  bool? approval;
  final String userId;
  String? image;

  Postmodel({
    required this.id,
    this.placeName,
    this.description,
    this.location,
    this.governorate,
    this.placeType,
    this.rating,
    this.approval,
    required this.userId,
    this.image,
  });
}