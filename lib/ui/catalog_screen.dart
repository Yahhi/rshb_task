import 'package:flutter/material.dart';
import 'package:rshb_task/consts/routes.dart';
import 'package:rshb_task/model/details_route_parameters.dart';
import 'package:rshb_task/model/product.dart';

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
      ),
      body: RaisedButton(
        child: Text('open details'),
        onPressed: _openDetails,
      ),
    );
  }

  void _openDetails() {
    Navigator.of(context).pushNamed(AppRoutes.DETAILS_ROUTE,
        arguments: DetailsRouteParameters(Product(1, 'молоко')));
  }
}
