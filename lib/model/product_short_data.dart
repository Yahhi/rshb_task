class ProductShortData {
  final int id;
  final String title;
  final String image;
  final int price; //в копейках
  final double averageMark;
  final int marksCount;
  final String description;
  final String category;
  final bool isFavorite;
  final String manufacturer;
  final String unit;

  ProductShortData(
    this.id,
    this.title, {
    this.price,
    this.image,
    this.averageMark,
    this.marksCount,
    this.description,
    this.category,
    this.isFavorite = false,
    this.manufacturer,
    this.unit,
  });

  factory ProductShortData.fromJson(Map<String, dynamic> json) =>
      ProductShortData(
        json['id'],
        json['title'],
        price: json['price'],
        image: json['image'],
        averageMark: json['averageMark'],
        marksCount: json['marksCount'],
        description: json['description'],
        category: json['category'],
        manufacturer: json['manufacturer'],
        unit: json['unit'],
      );

  @override
  String toString() {
    return 'Product ($id, "$title", "$image", $price, $averageMark, $marksCount, "$description", "$category", "$manufacturer", "$unit", $isFavorite)';
  }
}
