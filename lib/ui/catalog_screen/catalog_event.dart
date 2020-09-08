import 'package:equatable/equatable.dart';
import 'package:rshb_task/model/product_short_data.dart';

abstract class CatalogEvent extends Equatable {}

class CategorySelectionEvent extends CatalogEvent {
  final String category;

  CategorySelectionEvent({this.category});
  @override
  List<Object> get props => [category];
}

class OrderSelectionEvent extends CatalogEvent {
  final bool isOrderedByRating;
  final bool isOrderedByPrice;

  OrderSelectionEvent(
      {this.isOrderedByRating = false, this.isOrderedByPrice = false});

  @override
  List<Object> get props => [isOrderedByRating, isOrderedByPrice];
}

class DataLoadedEvent extends CatalogEvent {
  final List<ProductShortData> data;

  DataLoadedEvent(this.data);

  @override
  List<Object> get props => data;
}

class SetFavoritesPropertyEvent extends CatalogEvent {
  final int id;
  final bool isFavorite;

  SetFavoritesPropertyEvent(this.id, this.isFavorite);

  @override
  List<Object> get props => [id, isFavorite];
}
