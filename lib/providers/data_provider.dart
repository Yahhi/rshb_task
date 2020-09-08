import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:rshb_task/model/product.dart';
import 'package:rshb_task/model/product_short_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataProvider {
  static const _fileName = 'assets/data/data.json';

  final _random = Random();
  List<Product> _loadedData;
  Future<bool> _isLoaded;
  SharedPreferences _preferences;

  DataProvider({SharedPreferences preferences, String dataFilename}) {
    _isLoaded = _initData(preferences, dataFilename);
  }

  Future<bool> _initData(
      SharedPreferences preferences, String dataFilename) async {
    _preferences = preferences ?? (await SharedPreferences.getInstance());
    final fileContent = dataFilename == null
        ? (await PlatformAssetBundle().loadString(_fileName))
        : await File(dataFilename).readAsString();
    final List<dynamic> jsonArray = jsonDecode(fileContent);
    _loadedData =
        jsonArray.map((e) => Product.fromJson(e)).toList(growable: false);
    await _applySavedFavorites();
    return true;
  }

  Future<List<ProductShortData>> getData(
      {List<String> categoryFilter,
      bool isOrderedByRating = false,
      bool isOrderedByPrice = false}) async {
    await _isLoaded;
    await Future.delayed(Duration(milliseconds: _random.nextInt(300) + 300));
    final calculatedData = categoryFilter == null || categoryFilter.isEmpty
        ? List<Product>.from(_loadedData, growable: false)
        : _loadedData
            .where((element) => categoryFilter.contains(element.category))
            .toList(growable: false);
    if (isOrderedByRating)
      calculatedData.sort((a, b) => b.averageMark.compareTo(a.averageMark));
    if (isOrderedByPrice)
      calculatedData.sort((a, b) => a.price.compareTo(b.price));
    return calculatedData.map((e) => e.shortData).toList(growable: false);
  }

  Future<Product> getDetails(int id) async {
    await _isLoaded;
    await Future.delayed(Duration(milliseconds: _random.nextInt(300) + 300));
    return _loadedData.firstWhere((element) => element.id == id);
  }

  Future _applySavedFavorites() async {
    for (var i = 0; i < _loadedData.length; i++) {
      if (_preferences.containsKey(_loadedData[i].id.toString())) {
        _loadedData[i] = _loadedData[i]
            .applyFavorite(_preferences.getBool(_loadedData[i].id.toString()));
      }
    }
  }

  Future<bool> applyFavorites(int id, bool isFavorite) async {
    await _isLoaded;
    if (isFavorite) {
      _preferences.setBool(id.toString(), isFavorite);
    } else {
      _preferences.remove(id.toString());
    }
    final index = _loadedData.indexWhere((element) => element.id == id);
    _loadedData[index] = _loadedData[index].applyFavorite(isFavorite);
    return true;
  }
}
