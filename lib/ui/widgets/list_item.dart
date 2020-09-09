import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rshb_task/consts/colors.dart';
import 'package:rshb_task/consts/routes.dart';
import 'package:rshb_task/model/details_route_parameters.dart';
import 'package:rshb_task/model/product_short_data.dart';
import 'package:rshb_task/ui/catalog_screen/catalog_bloc.dart';
import 'package:rshb_task/ui/catalog_screen/catalog_event.dart';
import 'package:rshb_task/ui/widgets/favorites_button.dart';
import 'package:rshb_task/ui/widgets/mark_view.dart';
import 'package:rshb_task/ui/widgets/product_title.dart';
import 'package:rshb_task/utils/view_helper.dart';

class ListItem extends StatelessWidget {
  static const leftPadding = 12.0;

  final ProductShortData data;

  const ListItem(
    this.data, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _openDetails(context),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(data.image),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(top: 11, right: 11),
                    child: FavoritesButton(
                      isSelected: data.isFavorite,
                      onSelectionChange: (isSelected) =>
                          BlocProvider.of<CatalogBloc>(context).add(
                              SetFavoritesPropertyEvent(data.id, isSelected)),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: leftPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 12,
                    ),
                    ProductTitle(
                      data.title,
                      data.unit,
                      isSmall: true,
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    MarkView(
                      mark: data.averageMark,
                      marksCount: data.marksCount,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      data.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.shadedText,
                        fontSize: 10.0,
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      data.manufacturer,
                      style: TextStyle(
                          color: AppColors.appBarText, fontSize: 10.0),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          ViewHelper.readablePrice(data.price),
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _openDetails(BuildContext context) async {
    await Navigator.of(context).pushNamed(AppRoutes.detailsRoute,
        arguments: DetailsRouteParameters(data));
    BlocProvider.of<CatalogBloc>(context).add(NeedUpdateEvent());
  }
}
