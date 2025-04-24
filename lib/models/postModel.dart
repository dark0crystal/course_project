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
  String? id;
  String? userId;
  bool? approval;		
  String? placeName;
  String? location;
  String? description;
  int? rating;
  String? governorate;
  String? placeType;
  String? image;
  Postmodel({required this.id , required this.userId, required this.approval ,required this.description ,required this.governorate,required this.location,required this.placeName,required this.placeType,required this.rating ,  this.image});
}