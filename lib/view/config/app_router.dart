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
