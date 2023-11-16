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
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: const MainAppBarWidget(
        title: 'Category',
      ),
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              itemCount: state.categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.15,
                mainAxisSpacing: 20,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return Center(
                    child:
                        CategoryCardWidget(category: state.categories[index]));
              },
            );
          } else {
            return const Text('Something went wrong!!!');
          }
        },
      ),
      bottomNavigationBar: const MainBottomNavBar(),
    );
  }
}
