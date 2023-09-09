import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gromart_project/models/models.dart';
import '../screens/screens.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    log('This is route: ${settings.name}');

    switch (settings.name) {
      case '/':
        return HomeScreen.route();
      case HomeScreen.routeName:
        return HomeScreen.route();
      case SplashScreen.routeName:
        return SplashScreen.route();
      case CartScreen.routeName:
        return CartScreen.route();
      case AddressScreen.routeName:
        return AddressScreen.route();
      case CheckoutScreen.routeName:
        return CheckoutScreen.route();
      case OrdersScreen.routeName:
        return OrdersScreen.route();
      case AddAddressScreen.routeName:
        return AddAddressScreen.route();
        case EditAddressScreen.routeName:
        return EditAddressScreen.route(address: settings.arguments as AddressModel);
      case WishlistScreen.routeName:
        return WishlistScreen.route();
      case NotificationScreen.routeName:
        return NotificationScreen.route();
      case ProfileScreen.routeName:
        return ProfileScreen.route();
      case CategoryScreen.routeName:
        return CategoryScreen.route();
      case ResetPasswordPage.routeName:
        return ResetPasswordPage.route();
      case GetStartedPage.routeName:
        return GetStartedPage.route();
      case OrderConfirmation.routeName:
        return OrderConfirmation.route();
      case ProductScreen.routeName:
        return ProductScreen.route(product: settings.arguments as ProductModel);
      case EachCategoryScreen.routeName:
        return EachCategoryScreen.route(
            category: settings.arguments as CategoryModel);

      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
      ),
    );
  }
}
