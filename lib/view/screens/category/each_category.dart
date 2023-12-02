import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/blocs/blocs.dart';
import 'package:gromart_project/models/models.dart';
import 'package:gromart_project/view/config/colors.dart';
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
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: CustomAppBarWidget(title: category.name, actionList: const []),
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
            final List<ProductModel> eachCategoryProducts = state.products
                .where((product) => product.category == category.name)
                .toList();
            return GridView.builder(
              itemCount: eachCategoryProducts.length,
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.03,
                vertical: size.width * 0.01,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                mainAxisSpacing: size.width * 0.05,
                crossAxisSpacing: size.width * 0.03,
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
    );
  }
}
