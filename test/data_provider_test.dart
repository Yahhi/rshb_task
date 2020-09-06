import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rshb_task/model/product.dart';
import 'package:rshb_task/model/product_short_data.dart';
import 'package:rshb_task/providers/data_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() {
  final milk = Product(1, "Молоко 5%",
      image: "http://lorempixel.com/400/200/food/1/",
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
      unit: '1 литр');
  final cheese = Product(
    2,
    "Сыр Пармезан",
    image: "http://lorempixel.com/640/480/food/2/",
    price: 10850,
    averageMark: 3.5,
    marksCount: 7,
    description: "Наш сыр имеет уникальный вкус, цвет и запах.",
    weightNetto: 0.600,
    weightBrutto: 0.700,
    category: "Сырный продукт",
    type: "Столовое",
    bestBefore: 7,
    manufacturer: "Вкуснняев",
    isFavorite: false,
    unit: '1 килограмм',
  );
  final carrot = Product(
    3,
    "Морковь",
    image: "http://lorempixel.com/640/480/food/5/",
    price: 5000,
    averageMark: 4.9,
    marksCount: 2,
    description:
        "Как у бабушки на грядке\nВырос овощ очень сладкий,\nПроведем мы тренировку -\nКто быстрей сгрызет морковку",
    weightNetto: 1.000,
    weightBrutto: 1.000,
    category: "Овощи",
    type: "Столовое",
    bestBefore: 14,
    manufacturer: "Гроза полей",
    isFavorite: false,
    unit: '1 килограмм',
  );
  final cabbage = Product(
    2,
    "Капуста",
    image: "http://lorempixel.com/640/480/food/6/",
    price: 2390,
    averageMark: 2.0,
    marksCount: 1,
    description:
        "Бабушка Капуста\nКофт надела густо!\nКофта белая внутри,\nЗеленее – штуки три,\nГуще зелень – три еще,\nТолько это же не все!\nЛистья нижние, что внешне,\nСоставляют край одежды,\nНаклонились до земли,\nКорень спрятали они,\nЧтоб водичкою землица\nС ним могла бы поделиться!",
    weightNetto: 1.000,
    weightBrutto: 1.000,
    category: "Овощи",
    type: "Столовое",
    bestBefore: 7,
    manufacturer: "Гроза полей",
    isFavorite: false,
    unit: '1 килограмм',
  );

  setUpAll(() {
    WidgetsFlutterBinding.ensureInitialized();
  });

  group("list actions", () {
    DataProvider dataProvider;

    setUpAll(() {
      dataProvider = DataProvider(
        preferences: MockSharedPreferences(),
        dataFilename:
            'test_resources/data.json', //the file is placed in two paths: relative to test folder to run flutter test and relative to project to run in IDE
      );
    });

    test("data is decoded from json correctly", () async {
      final data = await dataProvider.getData(
          isOrderedByPrice: false, isOrderedByRating: false);
      expect(data.length, 4);
      expect(checkPropertiesEquality(data[0], milk.shortData), true);
      expect(checkPropertiesEquality(data[1], cheese.shortData), true);
      expect(checkPropertiesEquality(data[2], carrot.shortData), true);
      expect(checkPropertiesEquality(data[3], cabbage.shortData), true);
    });

    test("data is sorted by price correctly", () async {
      final data = await dataProvider.getData(isOrderedByPrice: true);
      expect(data.length, 4);
      expect(checkPropertiesEquality(data[0], cabbage.shortData), true);
      expect(checkPropertiesEquality(data[1], carrot.shortData), true);
      expect(checkPropertiesEquality(data[2], milk.shortData), true);
      expect(checkPropertiesEquality(data[3], cheese.shortData), true);
    });

    test("data is sorted by rating correctly", () async {
      final data = await dataProvider.getData(isOrderedByRating: true);
      expect(data.length, 4);
      expect(checkPropertiesEquality(data[0], milk.shortData), true);
      expect(checkPropertiesEquality(data[1], carrot.shortData), true);
      expect(checkPropertiesEquality(data[2], cheese.shortData), true);
      expect(checkPropertiesEquality(data[3], cabbage.shortData), true);
    });

    test("data is filtered by category correctly", () async {
      final data = await dataProvider.getData(
          categoryFilter: "Овощи",
          isOrderedByRating: false,
          isOrderedByPrice: false);
      expect(data.length, 2);
      expect(checkPropertiesEquality(data[0], carrot.shortData), true);
      expect(checkPropertiesEquality(data[1], cabbage.shortData), true);
    });

    test("data is filtered and sorted correctly", () async {
      final data = await dataProvider.getData(
          categoryFilter: "Овощи",
          isOrderedByPrice: true,
          isOrderedByRating: false);
      expect(data.length, 2);
      expect(checkPropertiesEquality(data[0], cabbage.shortData), true);
      expect(checkPropertiesEquality(data[1], carrot.shortData), true);
    });
  });

  group("favorites actions", () {
    test("saved favorites are applied correctly", () async {
      final preferences =
          MockSharedPreferences(savedValues: {'1': true, '3': true});
      final dataProvider = DataProvider(
        preferences: preferences,
        dataFilename: 'test_resources/data.json',
      );

      final data = await dataProvider.getData(
          isOrderedByPrice: false, isOrderedByRating: false);
      expect(data.length, 4);
      expect(data[0].isFavorite, true);
      expect(data[1].isFavorite, false);
      expect(data[2].isFavorite, true);
      expect(data[3].isFavorite, false);
    });

    test("favorite property is saved to preferences when changed", () async {
      final preferences =
          MockSharedPreferences(savedValues: {'1': true, '3': true});
      final dataProvider = DataProvider(
        preferences: preferences,
        dataFilename: 'test_resources/data.json',
      );

      dataProvider.applyFavorites(2, true);
      dataProvider.applyFavorites(1, false);
      final data = await dataProvider.getData(
          isOrderedByPrice: false, isOrderedByRating: false);
      expect(data.length, 4);
      expect(data[0].isFavorite, false);
      expect(data[1].isFavorite, true);
      expect(data[2].isFavorite, true);
      expect(data[3].isFavorite, false);
    });
  });
}

bool checkPropertiesEquality(ProductShortData a, ProductShortData b) {
  return b.id == a.id &&
      b.title == a.title &&
      b.image == a.image &&
      b.price == a.price &&
      b.averageMark == a.averageMark &&
      b.marksCount == a.marksCount &&
      b.description == a.description &&
      b.category == a.category &&
      b.isFavorite == a.isFavorite &&
      b.manufacturer == a.manufacturer &&
      a.unit == b.unit;
}

class MockSharedPreferences extends Mock implements SharedPreferences {
  Map<String, bool> savedValues;

  MockSharedPreferences({this.savedValues = const {}});

  bool containsKey(String key) => savedValues[key] ?? false;

  bool getBool(String key) => savedValues[key] ?? false;

  Future<bool> setBool(String key, bool value) async {
    savedValues[key] = value;
    return true;
  }

  Future<bool> remove(String key) async {
    savedValues.remove(key);
    return true;
  }
}
