class OmanInfoModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;

  OmanInfoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  factory OmanInfoModel.fromMap(String id, Map<String, dynamic> map) {
    return OmanInfoModel(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }
} 