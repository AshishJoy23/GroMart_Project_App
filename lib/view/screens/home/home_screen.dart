import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/blocs/blocs.dart';
import 'package:gromart_project/models/models.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const HomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String? currentUser = FirebaseAuth.instance.currentUser!.email;
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        BlocProvider.of<CartBloc>(context).add(LoadCart(email: currentUser!));
        BlocProvider.of<WishlistBloc>(context).add(WishListGetLoaded(email: currentUser));
        BlocProvider.of<AddressBloc>(context).add(AddressLoaded(email: currentUser));
        BlocProvider.of<CheckoutBloc>(context).add(const CheckoutUpdated());
        BlocProvider.of<OrdersBloc>(context).add(OrdersGetLoaded(email: currentUser));
      },
    );
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff4CAF50),
            Color(0xffC8E6C9),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        key: scaffoldKey,
        appBar: MainAppBarWidget(
          title: 'Explore!!!',
          scaffoldKey: scaffoldKey,
        ),
        drawer: const CustomDrawerWidget(),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  backgroundColor: Colors.white,
                  color: Colors.black,
                ),
              );
            }
            if (state is ProductLoaded) {
              return ListView(
                children: [
                  SearchBarWidget(),
                  CarouselSlider(
                    options: CarouselOptions(
                      aspectRatio: 1.58,
                      viewportFraction: 0.93,
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      autoPlay: true,
                    ),
                    items: CategoryModel.categories
                        .map((category) =>
                            CarouselCardWidget(category: category))
                        .toList(),
                  ),
                  const SectionTitleWidget(
                    title: 'RECOMMENDED',
                  ),
                  ProductCarouselWidget(
                    products: state.products,
                  ),
                  const SectionTitleWidget(
                    title: 'MOST POPULAR',
                  ),
                  ProductCarouselWidget(
                    products: state.products,
                  ),
                  const SectionTitleWidget(
                    title: 'TOP RATED',
                  ),
                  ProductCarouselWidget(
                    products: state.products,
                  ),
                  const SectionTitleWidget(
                    title: 'TODAY\'S SPECIAL',
                  ),
                  ProductCarouselWidget(
                    products: state.products,
                  ),
                ],
              );
            } else {
              return const Text('Something went wrong!!!');
            }
          },
        ),
        bottomNavigationBar: const MainBottomNavBar(),
      ),
    );
  }
}
