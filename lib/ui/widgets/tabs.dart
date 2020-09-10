import 'package:flutter/material.dart';
import 'package:rshb_task/consts/colors.dart';
import 'package:rshb_task/model/tab_selector.dart';
import 'package:rshb_task/ui/widgets/tab_selector_button.dart';

class Tabs extends StatelessWidget {
  final TabSelection selectedTab;
  final ValueChanged<TabSelection> onSelectionChange;

  const Tabs(
    this.selectedTab,
    this.onSelectionChange, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: AppColors.switcherBackground,
      ),
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: TabSelectorButton(
              TabSelection.products,
              onSelected: onSelectionChange,
              isSelected: selectedTab == TabSelection.products,
            ),
          ),
          Expanded(
            child: TabSelectorButton(
              TabSelection.farmers,
              onSelected: onSelectionChange,
              isSelected: selectedTab == TabSelection.farmers,
            ),
          ),
          Expanded(
            child: TabSelectorButton(
              TabSelection.tours,
              onSelected: onSelectionChange,
              isSelected: selectedTab == TabSelection.tours,
            ),
          ),
        ],
      ),
    );
  }
}
