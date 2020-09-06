import 'package:flutter_test/flutter_test.dart';
import 'package:rshb_task/model/product.dart';

main() {
  final milk = Product(1, "Молоко 5%",
      price: 10000,
      averageMark: 5.0,
      marksCount: 7,
      description:
          "Наше молоко и сливки поступают на завод в тот же день, когда доят коров, и это свежее пастеризованное для обеспечения качества при сохранении его свежего фермерского вкуса и питательной ценности. Мы делаем это, чтобы ваша семья могла наслаждаться клеверным молоком и сливками с чистой совестью и хорошим здоровьем! Без гармона роста (rBST) и без антибиотиков — свежего пастеризованного для обеспечения качества — без глютена — с низким содержанием натрия.",
      weightNetto: 1.680,
      weightBrutto: 1.780,
      category: "Сырный продукт",
      type: "Столовое",
      bestBefore: 7,
      manufacturer: "Вкуснняев",
      isFavorite: false,
      unit: "1 литр");

  test("product can be transformed to short product with the same field values",
      () {
    final shortProduct = milk.shortData;
    expect(shortProduct.id, milk.id);
    expect(shortProduct.title, milk.title);
    expect(shortProduct.image, milk.image);
    expect(shortProduct.isFavorite, milk.isFavorite);
    expect(shortProduct.price, milk.price);
    expect(shortProduct.averageMark, milk.averageMark);
    expect(shortProduct.category, milk.category);
    expect(shortProduct.manufacturer, milk.manufacturer);
    expect(shortProduct.description, milk.description);
    expect(shortProduct.marksCount, milk.marksCount);
    expect(shortProduct.unit, milk.unit);
  });
}
