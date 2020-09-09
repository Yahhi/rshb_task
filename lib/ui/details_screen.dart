import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rshb_task/consts/colors.dart';
import 'package:rshb_task/model/details_route_parameters.dart';
import 'package:rshb_task/model/product.dart';
import 'package:rshb_task/providers/data_provider.dart';
import 'package:rshb_task/ui/widgets/app_bar_back.dart';
import 'package:rshb_task/ui/widgets/favorites_button.dart';
import 'package:rshb_task/ui/widgets/product_title.dart';
import 'package:rshb_task/ui/widgets/properties_item.dart';
import 'package:rshb_task/utils/view_helper.dart';

import 'widgets/mark_view.dart';

class DetailsScreen extends StatefulWidget {
  final DetailsRouteParameters params;

  const DetailsScreen(
    this.params, {
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DetailsScreenState();
  }
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool hasFullDetails = false;
  bool isFavorite;

  @override
  void initState() {
    isFavorite = widget.params.product.isFavorite;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Product>(
        initialData: widget.params.product.toFullProduct(),
        future: RepositoryProvider.of<DataProvider>(context)
            .getDetails(widget.params.product.id),
        builder: (context, data) {
          final product = data.data;
          return Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              alignment: Alignment.topCenter,
              //scale: 0.1,
              //fit: BoxFit.contain,
              image: NetworkImage(
                product.image,
              ),
            )),
            child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
                    expandedHeight: 200.0,
                    floating: false,
                    pinned: true,
                    leading: AppBarBack(),
                    actions: [
                      Padding(
                        padding: EdgeInsets.only(right: 16.0),
                        child: FavoritesButton(
                          isSelected: isFavorite,
                          onSelectionChange: _updateProductFavorites,
                          isSmall: false,
                        ),
                      ),
                    ],
                    flexibleSpace: FlexibleSpaceBar(),
                  ),
                ];
              },
              body: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: AppColors.background,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                          ProductTitle(
                            product.title,
                            product.unit,
                            isSmall: false,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          MarkView(
                            mark: product.averageMark,
                            marksCount: product.marksCount,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            ViewHelper.readablePrice(product.price),
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            product.description,
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                        ] +
                        (hasFullDetails
                                ? product.properties
                                : product.shortProperties)
                            .map((property) =>
                                PropertiesItem(property.key, property.value))
                            .toList(growable: false) +
                        [
                          FlatButton(
                            padding: EdgeInsets.all(0.0),
                            onPressed: _changePropertiesVisibility,
                            child: Row(
                              children: [
                                Text(
                                  hasFullDetails
                                      ? 'Скрыть характеристики'
                                      : 'Все характеристики',
                                  style: TextStyle(
                                    color: AppColors.accent,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.0,
                                  ),
                                ),
                                Icon(
                                  hasFullDetails
                                      ? Icons.keyboard_arrow_up
                                      : Icons.chevron_right,
                                  color: AppColors.accent,
                                ),
                              ],
                            ),
                          ),
                        ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future _updateProductFavorites(bool isFavorite) async {
    RepositoryProvider.of<DataProvider>(context)
        .applyFavorites(widget.params.product.id, isFavorite);

    setState(() {
      this.isFavorite = isFavorite;
    });
  }

  void _changePropertiesVisibility() {
    setState(() {
      hasFullDetails = !hasFullDetails;
    });
  }
}
