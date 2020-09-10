import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rshb_task/model/product_short_data.dart';
import 'package:rshb_task/model/tab_selector.dart';
import 'package:rshb_task/ui/catalog_screen/catalog_bloc.dart';
import 'package:rshb_task/ui/catalog_screen/catalog_event.dart';
import 'package:rshb_task/ui/widgets/list_item.dart';
import 'package:rshb_task/ui/widgets/list_selector_button.dart';
import 'package:rshb_task/ui/widgets/tabs.dart';

import 'catalog_state.dart';

class CatalogScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CatalogScreenState();
  }
}

class _CatalogScreenState extends State<CatalogScreen> {
  TabSelection _selection = TabSelection.products;
  final _pageController = PageController(initialPage: 0);
  final _selectorsViewController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CatalogBloc, CatalogState>(builder: (context, state) {
        return NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 240,
                title: Text('Каталог'),
                leading: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 16),
                  child: InkWell(
                    onTap: Navigator.of(context).pop,
                    child: Container(
                      width: 40.0,
                      height: 40.0,
                      child: Center(
                        child: SvgPicture.asset('assets/arr_left.svg'),
                      ),
                    ),
                  ),
                ),
                pinned: true,
                flexibleSpace: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    Tabs(_selection, _onTabSelectionChange),
                    SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      height: 76,
                      child: PageView(
                        physics: NeverScrollableScrollPhysics(),
                        controller: _selectorsViewController,
                        children: [
                          _buildSelectors(
                              context,
                              state.selectedCategories ?? [],
                              state.isOrderedByRating ?? false,
                              state.isOrderedByPrice ?? false),
                          Container(),
                          Container(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: [
              state is LoadingCatalogState
                  ? _progress
                  : state.data == null || state.data.isEmpty
                      ? _noItemsText
                      : _buildList(context, state.data),
              Container(),
              Container(),
            ],
          ),
        );
      }),
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
    return ListView(
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

  void _onTabSelectionChange(TabSelection value) {
    print('updated page: ${value.toTabIndex()}');
    _pageController.animateToPage(value.toTabIndex(),
        curve: Curves.bounceIn, duration: Duration(milliseconds: 300));
    _selectorsViewController.animateToPage(value.toTabIndex(),
        curve: Curves.bounceIn, duration: Duration(milliseconds: 300));
    setState(() {
      _selection = value;
    });
  }
}
