import 'package:flutter/material.dart';
import 'package:rshb_task/model/details_route_parameters.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: ScrollPhysics(parent: PageScrollPhysics()),
        slivers: [
          SliverAppBar(
            title: Text(widget.params.product.title),
          ),
        ],
      ),
    );
  }
}
