import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rshb_task/model/product_short_data.dart';
import 'package:rshb_task/providers/data_provider.dart';
import 'package:rshb_task/ui/catalog_screen/catalog_event.dart';
import 'package:rshb_task/ui/catalog_screen/catalog_state.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  final DataProvider dataProvider;

  CatalogBloc(this.dataProvider)
      : super(LoadingCatalogState(
            isOrderedByRating: true, isOrderedByPrice: false)) {
    _loadData(isOrderedByRating: true);
  }

  @override
  Stream<CatalogState> mapEventToState(CatalogEvent event) async* {
    if (event is CategorySelectionEvent) {
      var categories = state.selectedCategories ?? List<String>();
      final indexInsideSelected = categories.indexOf(event.category);
      List<String> updatedCategories;
      if (indexInsideSelected == -1) {
        updatedCategories = categories + [event.category];
      } else {
        updatedCategories = List<String>.from(categories);
        updatedCategories.removeAt(indexInsideSelected);
      }
      yield state.copyWith(
          isLoading: true, selectedCategories: updatedCategories);
      _loadData(
          categories: updatedCategories,
          isOrderedByPrice: state.isOrderedByPrice,
          isOrderedByRating: state.isOrderedByRating);
    } else if (event is OrderSelectionEvent) {
      yield state.copyWith(
          isLoading: true,
          isOrderedByPrice: event.isOrderedByPrice,
          isOrderedByRating: event.isOrderedByRating);
      _loadData(
          categories: state.selectedCategories,
          isOrderedByPrice: event.isOrderedByPrice,
          isOrderedByRating: event.isOrderedByRating);
    } else if (event is SetFavoritesPropertyEvent) {
      final data = List<ProductShortData>.from(state.data);
      final indexOfUpdated =
          data.indexWhere((element) => element.id == event.id);
      data[indexOfUpdated] =
          data[indexOfUpdated].copyWithUpdatedFavorites(event.isFavorite);
      yield state.copyWith(data: data);
      dataProvider.applyFavorites(event.id, event.isFavorite);
    } else if (event is DataLoadedEvent) {
      yield state.copyWith(data: event.data);
    }
  }

  Future _loadData(
      {List<String> categories,
      bool isOrderedByRating = false,
      bool isOrderedByPrice = false}) async {
    final data = await dataProvider.getData(
        categoryFilter: categories,
        isOrderedByRating: isOrderedByRating,
        isOrderedByPrice: isOrderedByPrice);
    add(DataLoadedEvent(data));
  }
}
