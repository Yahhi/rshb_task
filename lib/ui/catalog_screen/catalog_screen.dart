import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rshb_task/model/product.dart';
import 'package:rshb_task/ui/widgets/list_item.dart';
import 'package:rshb_task/ui/widgets/list_selector_button.dart';

class CatalogScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CatalogScreenState();
  }
}

class _CatalogScreenState extends State<CatalogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Каталог'),
        leading: IconButton(
          icon: SvgPicture.asset('assets/arr_left.svg'),
          onPressed: Navigator.of(context).pop,
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 30.0,
          ),
          Container(
            height: 76,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                SizedBox(
                  width: 8.0,
                ),
                ListSelectorButton(
                  'Сортировать',
                  'assets/sort.svg',
                  isSelected: true,
                ),
                ListSelectorButton('Овощи и фрукты', 'assets/vegetables.svg'),
                ListSelectorButton('Хлеб и выпечка', 'assets/bread.svg'),
                ListSelectorButton('Молоко и яйца', 'assets/milk.svg'),
                ListSelectorButton('Мясо', 'assets/milk.svg'),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 0.66,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                ListItem(Product(1, "Молоко 5%",
                        image: "http://lorempixel.com/400/200/food/1/",
                        price: 10000,
                        averageMark: 5.0,
                        marksCount: 7,
                        description:
                            "Наше молоко и сливки поступают на завод в тот же день, когда доят коров, и это свежее пастеризованное для обеспечения качества при сохранении его свежего фермерского вкуса и питательной ценности. Мы делаем это, чтобы ваша семья могла наслаждаться клеверным молоком и сливками с чистой совестью и хорошим здоровьем! Без гармона роста (rBST) и без антибиотиков — свежего пастеризованного для обеспечения качества — без глютена — с низким содержанием натрия.",
                        weightNetto: 1.680,
                        weightBrutto: 1.780,
                        category: "Сырный продукт",
                        type: "Столовое",
                        bestBefore: 7,
                        manufacturer: "Вкуснняев",
                        unit: "1 л",
                        isFavorite: false)
                    .shortData),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
