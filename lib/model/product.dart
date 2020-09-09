import 'package:rshb_task/model/product_short_data.dart';

class Product {
  final int id;
  final String title;
  final String image;
  final int price; //в копейках
  final double averageMark;
  final int marksCount;
  final String description;
  final double weightNetto;
  final double weightBrutto; // с упаковкой
  final String category;
  final String type;
  final int bestBefore; // срок годности в днях
  final bool isFavorite;
  final String manufacturer;
  final String unit;

  Product(
    this.id,
    this.title, {
    this.image,
    this.price = 0,
    this.averageMark = 0.0,
    this.marksCount = 0,
    this.description,
    this.weightNetto,
    this.weightBrutto,
    this.category,
    this.type,
    this.bestBefore = 1,
    this.isFavorite = false,
    this.manufacturer,
    this.unit,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        json['id'],
        json['title'],
        image: json['image'],
        price: json['price'],
        averageMark: json['averageMark'],
        marksCount: json['marksCount'],
        description: json['description'],
        weightNetto: json['weightNetto'],
        weightBrutto: json['weightBrutto'],
        category: json['category'],
        type: json['type'],
        bestBefore: json['bestBefore'],
        manufacturer: json['manufacturer'],
        unit: json['unit'],
      );

  List<MapEntry<String, String>> get properties => [
        MapEntry('Вес продукта', _weightNettoString),
        MapEntry('Вес продукта с упаковкой', _weightBruttoString),
        MapEntry('Категория', category),
        MapEntry('Тип маркировки', type),
        MapEntry('Срок годности', '$bestBefore суток'),
        MapEntry('Вес продукта', _weightNettoString),
        MapEntry('Вес продукта с упаковкой', _weightBruttoString),
        MapEntry('Категория', category),
        MapEntry('Тип маркировки', type),
        MapEntry('Срок годности', '$bestBefore суток'),
      ];

  String get _weightBruttoString =>
      weightBrutto == null ? '-' : '${weightBrutto.toStringAsFixed(3)} кг';
  String get _weightNettoString =>
      weightNetto == null ? '-' : '${weightNetto.toStringAsFixed(3)} кг';

  List<MapEntry<String, String>> get shortProperties => [
        MapEntry('Вес продукта', _weightNettoString),
        MapEntry('Вес продукта с упаковкой', _weightBruttoString),
        MapEntry('Категория', category),
        MapEntry('Тип маркировки', type),
        MapEntry('Срок годности', '$bestBefore суток'),
      ];

  Product applyFavorite(bool isFavorite) {
    return Product(
      id,
      title,
      image: image,
      price: price,
      averageMark: averageMark,
      marksCount: marksCount,
      description: description,
      weightNetto: weightNetto,
      weightBrutto: weightBrutto,
      category: category,
      type: type,
      bestBefore: bestBefore,
      manufacturer: manufacturer,
      isFavorite: isFavorite,
      unit: unit,
    );
  }

  ProductShortData get shortData => ProductShortData(id, title,
      price: price,
      image: image,
      averageMark: averageMark,
      marksCount: marksCount,
      description: description,
      category: category,
      isFavorite: isFavorite,
      manufacturer: manufacturer,
      unit: unit);

  @override
  String toString() {
    return 'Product ($id, "$title", $price, $averageMark, $marksCount, "$description", $weightNetto, $weightBrutto, "$category", "$type", $bestBefore, "$manufacturer", "$unit", $isFavorite)';
  }
}
