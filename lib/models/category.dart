class Categorie {
  final String imageUrl;
  final String name;

  Categorie({required this.name, required this.imageUrl});

  factory Categorie.fromJson(Map<String, dynamic> json) {
    return Categorie(
      name: json['name'],
      imageUrl: json['image'],
    );
  }
}
