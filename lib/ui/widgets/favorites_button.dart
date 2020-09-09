import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rshb_task/consts/colors.dart';

class FavoritesButton extends StatelessWidget {
  final bool isSelected;
  final Function(bool) onSelectionChange;
  final bool isSmall;

  const FavoritesButton(
      {Key key,
      this.isSelected = false,
      @required this.onSelectionChange,
      this.isSmall = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onSelectionChange(!isSelected),
      child: Container(
        width: isSmall ? 32.0 : 40.0,
        height: isSmall ? 32.0 : 40.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.innerBorder),
          color: AppColors.background,
        ),
        child: Center(
          child: SvgPicture.asset(
            isSelected ? 'assets/favorites_filled.svg' : 'assets/favorites.svg',
            width: 16,
            height: 16,
          ),
        ),
      ),
    );
  }
}
