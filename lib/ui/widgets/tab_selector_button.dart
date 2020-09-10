import 'package:flutter/material.dart';
import 'package:rshb_task/consts/colors.dart';
import 'package:rshb_task/model/tab_selector.dart';

class TabSelectorButton extends StatelessWidget {
  final TabSelection tabName;
  final ValueChanged<TabSelection> onSelected;
  final bool isSelected;

  const TabSelectorButton(this.tabName,
      {Key key, this.onSelected, this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: InkWell(
        onTap: isSelected ? null : () => onSelected(tabName),
        child: Container(
          padding: EdgeInsets.all(5),
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: isSelected ? AppColors.accent : Colors.transparent,
          ),
          alignment: Alignment.center,
          child: Text(
            tabName.toShortString(),
            style: TextStyle(
                color: isSelected ? AppColors.background : AppColors.appBarText,
                fontSize: 14.0,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
