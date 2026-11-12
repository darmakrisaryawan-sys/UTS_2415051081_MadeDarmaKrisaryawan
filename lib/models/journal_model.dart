class JournalModel {
  final int? id;
  final String cultureId;
  final String title;
  final String note;
  final int rating;
  final DateTime? createdAt;

  JournalModel({
    this.id,
    required this.cultureId,
    required this.title,
    required this.note,
    required this.rating,
    this.createdAt,
  });

  factory JournalModel.fromJson(Map<String, dynamic> json) {
    return JournalModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()),
      cultureId: json['culture_id']?.toString() ?? '0',
      title: json['title'] ?? '',
      note: json['note'] ?? '',
      rating: json['rating'] is int
          ? json['rating']
          : int.tryParse(json['rating'].toString()) ?? 5,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'culture_id': cultureId,
      'title': title,
      'note': note,
      'rating': rating,
    };
  }
}
