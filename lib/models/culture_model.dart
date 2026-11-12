class CultureModel {
  final String id;
  final String name;
  final String category;
  final String location;
  final String description;
  final String imageUrl;

  CultureModel({
    required this.id,
    required this.name,
    required this.category,
    required this.location,
    required this.description,
    required this.imageUrl,
  });

  factory CultureModel.fromJson(Map<String, dynamic> json) {
    return CultureModel(
      id: json['id'].toString(),
      name: json['name'] ?? 'Tanpa Nama',
      category: json['category'] ?? 'Umum',
      location: json['location'] ?? 'Bali',
      description: json['description'] ?? 'Tidak ada deskripsi.',
      imageUrl: json['image_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'location': location,
      'description': description,
      'image_url': imageUrl,
    };
  }
}