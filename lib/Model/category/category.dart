class CategoryModel {
  final String name;
  final String imageUrl;

  CategoryModel({required this.name, required this.imageUrl});

  // Convert a JSON map to a CategoryModel instance
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json['name'] ,
      imageUrl: json['image'] ,
    );
  }

  // Convert a CategoryModel instance to a JSON map
  Map<String, dynamic> toJson() => {
        'name': name,
        'imageUrl': imageUrl,
      };
}
