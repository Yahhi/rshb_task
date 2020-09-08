import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rshb_task/model/product_short_data.dart';
import 'package:rshb_task/ui/catalog_screen/catalog_bloc.dart';
import 'package:rshb_task/ui/catalog_screen/catalog_event.dart';
import 'package:rshb_task/ui/widgets/list_item.dart';
import 'package:rshb_task/ui/widgets/list_selector_button.dart';

import 'catalog_state.dart';

class CatalogScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CatalogScreenState();
  }
}

class _CatalogScreenState extends State<CatalogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Каталог'),
        leading: IconButton(
          icon: SvgPicture.asset('assets/arr_left.svg'),
          onPressed: Navigator.of(context).pop,
        ),
      ),
      body: BlocBuilder<CatalogBloc, CatalogState>(
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 30.0,
              ),
              _buildSelectors(
                  context,
                  state.selectedCategories ?? [],
                  state.isOrderedByRating ?? false,
                  state.isOrderedByPrice ?? false),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: state is LoadingCatalogState
                    ? _progress
                    : state.data == null || state.data.isEmpty
                        ? _noItemsText
                        : _buildList(context, state.data),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget get _noItemsText => Container(
        alignment: Alignment.topCenter,
        width: 100,
        height: 100,
        child: Text('Нет продуктов'),
      );

  Widget get _progress => Container(
        alignment: Alignment.topCenter,
        width: 100,
        height: 100,
        child: CircularProgressIndicator(),
      );

  Widget _buildSelectors(BuildContext context, List<String> selectedCategories,
      bool isOrderedByRating, bool isOrderedByPrice) {
    return Container(
      height: 76,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          SizedBox(
            width: 8.0,
          ),
          ListSelectorButton(
            'Сортировать',
            'assets/sort.svg',
            isSelected: isOrderedByPrice,
            action: () => BlocProvider.of<CatalogBloc>(context).add(
                OrderSelectionEvent(
                    isOrderedByRating: !isOrderedByRating,
                    isOrderedByPrice: !isOrderedByPrice)),
          ),
          ListSelectorButton(
            'Овощи и фрукты',
            'assets/vegetables.svg',
            isSelected: selectedCategories.contains('Овощи'),
            action: () => BlocProvider.of<CatalogBloc>(context)
                .add(CategorySelectionEvent(category: 'Овощи')),
          ),
          ListSelectorButton(
            'Хлеб и выпечка',
            'assets/bread.svg',
            isSelected: selectedCategories.contains('Хлеб'),
            action: () => BlocProvider.of<CatalogBloc>(context)
                .add(CategorySelectionEvent(category: 'Хлеб')),
          ),
          ListSelectorButton(
            'Молоко и яйца',
            'assets/milk.svg',
            isSelected: selectedCategories.contains('Сырный продукт'),
            action: () => BlocProvider.of<CatalogBloc>(context)
                .add(CategorySelectionEvent(category: 'Сырный продукт')),
          ),
          ListSelectorButton(
            'Мясо',
            'assets/milk.svg',
            isSelected: selectedCategories.contains('Мясо'),
            action: () => BlocProvider.of<CatalogBloc>(context)
                .add(CategorySelectionEvent(category: 'Мясо')),
          ),
        ],
      ),
    );
  }

  Widget _buildList(BuildContext context, List<ProductShortData> data) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 0.66,
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      children: data.map((e) => ListItem(e)).toList(growable: false),
    );
  }
}
