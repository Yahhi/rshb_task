class ViewHelper {
  static String readablePrice(int price) =>
      (price / 100).toStringAsFixed(price % 100 == 0 ? 0 : 2) + ' \u{20BD}';
}
