import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/blocs/blocs.dart';
import 'package:gromart_project/models/models.dart';
import 'package:gromart_project/view/widgets/custom_appbar.dart';
import 'package:gromart_project/view/widgets/product_card.dart';

class EachCategoryScreen extends StatelessWidget {
  final CategoryModel category;
  const EachCategoryScreen({
    super.key,
    required this.category,
  });

  static const String routeName = '/each_category';

  static Route route({required CategoryModel category}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => EachCategoryScreen(
        category: category,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final List<ProductModel> categoryProducts = ProductModel.products
    //     .where((product) => product.category == category.name)
    //     .toList();
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
        backgroundColor: Colors.transparent,
        appBar: CustomAppBarWidget(title: category.name, actionList: const []),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ProductLoaded) {
              final List<ProductModel> eachCategoryProducts = state.products.where((product) => product.category==category.name).toList();
              return GridView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                itemCount: eachCategoryProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.15,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return Center(
                    child: ProductCardWidget(
                      product: eachCategoryProducts[index],
                    ),
                  );
                },
              );
            } else {
              return const Text('Something went wrong!!!');
            }
          },
        ),
      ),
    );
  }
}
