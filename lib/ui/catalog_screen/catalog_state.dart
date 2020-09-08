import 'package:equatable/equatable.dart';
import 'package:rshb_task/model/product_short_data.dart';

class CatalogState extends Equatable {
  final List<ProductShortData> data;
  final bool isOrderedByPrice;
  final bool isOrderedByRating;
  final List<String> selectedCategories;

  CatalogState(this.data,
      {this.isOrderedByPrice = false,
      this.isOrderedByRating = false,
      this.selectedCategories});

  @override
  List<Object> get props =>
      [] + [isOrderedByPrice, isOrderedByRating, selectedCategories] + data ??
      [];

  CatalogState copyWith(
      {bool isOrderedByPrice,
      bool isOrderedByRating,
      List<String> selectedCategories,
      bool isLoading,
      List<ProductShortData> data}) {
    if (isLoading == true) {
      return LoadingCatalogState(
        isOrderedByRating: isOrderedByRating ?? this.isOrderedByRating,
        isOrderedByPrice: isOrderedByPrice ?? this.isOrderedByPrice,
        selectedCategories: selectedCategories ?? this.selectedCategories,
      );
    } else {
      return CatalogState(
        data ?? this.data,
        isOrderedByRating: isOrderedByRating ?? this.isOrderedByRating,
        isOrderedByPrice: isOrderedByPrice ?? this.isOrderedByPrice,
        selectedCategories: selectedCategories ?? this.selectedCategories,
      );
    }
  }
}

class LoadingCatalogState extends CatalogState {
  LoadingCatalogState(
      {bool isOrderedByPrice,
      bool isOrderedByRating,
      List<String> selectedCategories})
      : super(null,
            isOrderedByPrice: isOrderedByPrice,
            isOrderedByRating: isOrderedByRating,
            selectedCategories: selectedCategories);
}
