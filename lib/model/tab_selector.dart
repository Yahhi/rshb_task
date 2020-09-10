enum TabSelection { products, farmers, tours }

extension TabsHelper on TabSelection {
  String toShortString() {
    switch (this) {
      case TabSelection.products:
        return 'Продукты';
      case TabSelection.farmers:
        return 'Фермеры';
      case TabSelection.tours:
        return 'Агротуры';
      default:
        return this.toString().split('.').last;
    }
  }

  int toTabIndex() {
    switch (this) {
      case TabSelection.products:
        return 0;
      case TabSelection.farmers:
        return 1;
      case TabSelection.tours:
        return 2;
      default:
        return 0;
    }
  }
}
