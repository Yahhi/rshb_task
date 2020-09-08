import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rshb_task/consts/colors.dart';

class ListSelectorButton extends StatelessWidget {
  final bool isSelected;
  final String text;
  final String iconAddress;
  final VoidCallback action;

  const ListSelectorButton(
    this.text,
    this.iconAddress, {
    Key key,
    this.isSelected,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 4.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              child: Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ?? false
                        ? AppColors.accent
                        : AppColors.border,
                    width: 1.0,
                  ),
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  iconAddress,
                  width: 16.0,
                  height: 16.0,
                  color: isSelected ?? false ? AppColors.accent : null,
                ),
              ),
              onTap: action,
            ),
            GestureDetector(
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    color: isSelected ?? false
                        ? AppColors.accent
                        : AppColors.shadedText,
                    fontSize: 12.0,
                  ),
                  overflow: TextOverflow.fade,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
              onTap: action,
            ),
          ],
        ),
      ),
    );
  }
}
