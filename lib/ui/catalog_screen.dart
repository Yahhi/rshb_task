import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        leading: IconButton(
          icon: SvgPicture.asset('assets/arr_left.svg'),
          onPressed: Navigator.of(context).pop,
        ),
      ),
      body: RaisedButton(
        child: Text('open details'),
        onPressed: _openDetails,
      ),
    );
  }

  void _openDetails() {
    Navigator.of(context).pushNamed(AppRoutes.detailsRoute,
        arguments: DetailsRouteParameters(Product(1, 'молоко')));
  }
}
