import 'package:flutter/material.dart';
import 'package:rshb_task/consts/colors.dart';

class ProductTitle extends StatelessWidget {
  final String title;
  final String units;
  final bool isSmall;

  const ProductTitle(
    this.title,
    this.units, {
    Key key,
    this.isSmall = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isSmall ? 12.0 : 20.0,
            color: AppColors.appBarText,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Text(
            '/ $units',
            style: TextStyle(
              fontSize: isSmall ? 10.0 : 16.0,
              color: AppColors.shadedText,
            ),
          ),
        )
      ],
    );
  }
}
