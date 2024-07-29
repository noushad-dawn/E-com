class Vegetable {
  final String name;
  final double price;
  final String imageUrl;

  Vegetable({required this.name, required this.price, required this.imageUrl});

  factory Vegetable.fromJson(Map<String, dynamic> json) {
    return Vegetable(
      name: json['name'],
      price: json['price'],
      imageUrl: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'image': imageUrl,
    };
  }
}
