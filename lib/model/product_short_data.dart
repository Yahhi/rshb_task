import 'package:equatable/equatable.dart';

class ProductShortData extends Equatable {
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

  ProductShortData copyWithUpdatedFavorites(bool isFavorite) =>
      ProductShortData(this.id, this.title,
          price: price,
          image: image,
          averageMark: averageMark,
          marksCount: marksCount,
          description: description,
          category: category,
          isFavorite: isFavorite,
          manufacturer: manufacturer,
          unit: unit);

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

  @override
  List<Object> get props => [
        id,
        title,
        image,
        price,
        averageMark,
        marksCount,
        description,
        category,
        manufacturer,
        unit,
        isFavorite
      ];
}
