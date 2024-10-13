class Series {
  final String name;
  final String nameId;
  final String imageUrl;

  Series({required this.name, required this.nameId, required this.imageUrl});

  factory Series.fromJson(Map<String, dynamic> json) {
    return Series(
      name: json['name'],
      nameId: json['name_id'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'name_id': nameId,
      'image_url': imageUrl,
    };
  }
}
