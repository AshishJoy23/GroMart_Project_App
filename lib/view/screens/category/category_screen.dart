import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/blocs/blocs.dart';
import 'package:gromart_project/view/config/colors.dart';
import 'package:gromart_project/view/screens/category/widgets/category_card.dart';
import '../../widgets/widgets.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  static const String routeName = '/category';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const CategoryScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: const CustomAppBarWidget(title: 'Category', actionList: []),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 3,
                backgroundColor: Colors.white,
                color: Colors.black,
              ),
            );
          }
          if (state is CategoryLoaded) {
            return GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.03,
                vertical: size.width * 0.01,
              ),
              itemCount: state.categories.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.9,
                mainAxisSpacing: size.width * 0.02,
                crossAxisSpacing: size.width * 0.02,
              ),
              itemBuilder: (context, index) {
                return CategoryCardWidget(category: state.categories[index]);
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
