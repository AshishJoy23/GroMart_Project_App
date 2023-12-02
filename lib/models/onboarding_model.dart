class OnBoarding {
  final String title;
  final String subTitle;
  final String imageUrl;

  OnBoarding({
    required this.title,
    required this.subTitle,
    required this.imageUrl,
  });
}

List<OnBoarding> onBoardingData = [
  OnBoarding(
    title: 'Easy Shopping',
    subTitle: 'Now you can order your needs\nany time and any where',
    imageUrl: 'assets/images/easy_shopping.png',
  ),
  OnBoarding(
    title: 'Fresh Products',
    subTitle: 'Only quality and fresh groceries\nare available for you',
    imageUrl: 'assets/images/fresh_products.png',
  ),
  OnBoarding(
    title: 'Easy Payment',
    subTitle: 'Make your payments easily\nthrough seamless and secure way',
    imageUrl: 'assets/images/easy_payment.png',
  ),
  OnBoarding(
    title: 'Fast Delivery',
    subTitle: 'Fast delivery on same day and\ncustom delivery systems',
    imageUrl: 'assets/images/fast_delivery.png',
  ),
];
