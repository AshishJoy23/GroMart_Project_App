import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/blocs/blocs.dart';
import 'package:gromart_project/repositories/address/address_repository.dart';
import 'package:gromart_project/repositories/cart/cart_repository.dart';
import 'package:gromart_project/repositories/category/category_repository.dart';
import 'package:gromart_project/repositories/order/order_repository.dart';
import 'package:gromart_project/repositories/product/product_repository.dart';
import 'package:gromart_project/repositories/wishlist/wishlist_repository.dart';
import 'package:gromart_project/view/config/app_router.dart';
import 'package:gromart_project/view/config/theme.dart';
import 'package:gromart_project/view/config/utils.dart';
import 'package:gromart_project/view/screens/screens.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();
//final userEmail = FirebaseAuth.instance.currentUser!.email;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CategoryBloc(
            categoryRepository: CategoryRepository(),
          )..add(LoadCategories()),
        ),
        BlocProvider(
          create: (_) => ProductBloc(
            productRepository: ProductRepository(),
          )..add(LoadProducts()),
        ),
        BlocProvider(
          create: (_) => CartBloc(
            cartRepository: CartRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => WishlistBloc(
            wishlistRepository: WishlistRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => AddressBloc(
            addressRepository: AddressRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => OrdersBloc(
            orderRepository: OrderRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => PaymentBloc()..add(PaymentMethodLoaded()),
        ),
        BlocProvider(
          create: (context) => CheckoutBloc(
            orderRepository: OrderRepository(),
            cartRepository: CartRepository(),
            cartBloc: BlocProvider.of<CartBloc>(context),
            addressBloc: BlocProvider.of<AddressBloc>(context),
            paymentBloc: BlocProvider.of<PaymentBloc>(context),
          )..add(const CheckoutUpdated()),
        ),
        BlocProvider(
          create: (context) => SearchBloc(
            productBloc: BlocProvider.of<ProductBloc>(context),
          )..add(const SearchCleared()),
        ),
      ],
      child: MaterialApp(
        scaffoldMessengerKey: Utils.messengerKey,
        navigatorKey: navigatorKey,
        title: 'GroMart',
        debugShowCheckedModeBanner: false,
        theme: theme(),
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: SplashScreen.routeName,
      ),
    );
  }
}
