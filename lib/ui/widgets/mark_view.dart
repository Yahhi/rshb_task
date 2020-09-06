import 'package:flutter/material.dart';
import 'package:rshb_task/consts/colors.dart';

class MarkView extends StatelessWidget {
  final double mark;
  final int marksCount;

  const MarkView({Key key, this.mark, this.marksCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            color: _markBackground,
          ),
          alignment: Alignment.center,
          child: Text(
            _markText,
            style: TextStyle(
                color: AppColors.background,
                fontWeight: FontWeight.w600,
                fontSize: 10.0),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
          child: Text(
            _markCountText,
            style: TextStyle(color: AppColors.shadedText, fontSize: 10.0),
          ),
        )
      ],
    );
  }

  String get _markText => mark == null ? '\u{8213}' : mark.toStringAsFixed(1);

  Color get _markBackground => mark == null
      ? AppColors.innerBorder
      : mark >= 4 ? AppColors.accent : AppColors.mediumMark;

  String get _markCountText {
    if (marksCount == null) {
      return 'Нет оценок';
    } else {
      final ending = marksCount % 100;
      if (ending <= 20 && ending >= 11) {
        return '$marksCount оценок';
      } else if (ending == 1) {
        return '$marksCount оценка';
      } else if (ending <= 4 && ending >= 2) {
        return '$marksCount оценки';
      } else {
        return '$marksCount оценок';
      }
    }
  }
}
