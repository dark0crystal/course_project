class Review {
  final String id;
  final String userId;
  final String placeId;
  final double rating;
  final String title;
  final String description;

  Review({
    required this.id,
    required this.userId,
    required this.placeId,
    required this.rating,
    required this.title,
    required this.description,
  });
}