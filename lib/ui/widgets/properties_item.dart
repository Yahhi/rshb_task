import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:rshb_task/consts/colors.dart';

class PropertiesItem extends StatelessWidget {
  final String property;
  final String value;

  const PropertiesItem(
    this.property,
    this.value, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(property),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.0),
              child: DottedBorder(
                customPath: (size) => Path()
                  ..moveTo(0, size.height * 0.7)
                  ..lineTo(size.width, size.height * 0.7),
                radius: Radius.circular(1),
                dashPattern: [1, 1],
                color: AppColors.dotted_border,
                //strokeWidth: 0.5,
                child: Text(''),
              ),
            ),
          ),
          Text(value ?? '-'),
        ],
      ),
    );
  }
}
