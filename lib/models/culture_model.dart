class CultureModel {
  final String id;
  final String name;
  final String category;
  final String location;
  final String description;
  final String imageUrl;
  final List<String> galleryUrls;

  CultureModel({
    required this.id,
    required this.name,
    required this.category,
    required this.location,
    required this.description,
    required this.imageUrl,
    this.galleryUrls = const [],
  });

  factory CultureModel.fromJson(Map<String, dynamic> json) {
    final String mainImage = json['image_url'] ?? '';
    final List<String> parsedGallery = json['gallery_urls'] != null
        ? List<String>.from(json['gallery_urls'])
        : [];

    if (parsedGallery.isEmpty && mainImage.isNotEmpty) {
      parsedGallery.add(mainImage);
    }

    return CultureModel(
      id: json['id'].toString(),
      name: json['name'] ?? 'Tanpa Nama',
      category: json['category'] ?? 'Umum',
      location: json['location'] ?? 'Bali',
      description: json['description'] ?? 'Tidak ada deskripsi.',
      imageUrl: mainImage,
      galleryUrls: parsedGallery,
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
      'gallery_urls': galleryUrls,
    };
  }
}