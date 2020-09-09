import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rshb_task/consts/colors.dart';

class AppBarBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 16),
      child: InkWell(
        onTap: Navigator.of(context).pop,
        child: Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.innerBorder),
            color: AppColors.background,
          ),
          child: Center(
            child: SvgPicture.asset('assets/arr_left.svg'),
          ),
        ),
      ),
    );
  }
}
