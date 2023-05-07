class InformationModel {
  final String id;
  final String title;
  final String image;
  final String url;
  final String category;

  InformationModel({
    required this.id,
    required this.title,
    required this.image,
    required this.url,
    required this.category,
  });

  factory InformationModel.fromJson(Map<String, dynamic> json) =>
      InformationModel(
        id: json['id'] ?? '',
        title: json['title'] ?? '',
        image: json['image'] ?? '',
        url: json['url'] ?? '',
        category: json['category'] ?? '',
      );

  Map<String, String> toJson() => {
        'id': id,
        'title': title,
        'image': image,
        'url': url,
        'category': category,
      };
}
