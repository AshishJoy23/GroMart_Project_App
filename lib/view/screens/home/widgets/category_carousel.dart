import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/blocs/blocs.dart';
import 'package:gromart_project/models/category_model.dart';
import 'package:gromart_project/view/config/colors.dart';
import 'package:gromart_project/view/screens/screens.dart';

class CategoryCarouselWidget extends StatelessWidget {
  const CategoryCarouselWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.17,
      width: size.width,
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            return Center(
              child: Transform.scale(
                scale: 0.7,
                child: const CircularProgressIndicator(
                  strokeWidth: 3,
                  backgroundColor: Colors.white,
                  color: Colors.black,
                ),
              ),
            );
          } else if (state is CategoryLoaded) {
            return ListView.builder(
                padding: EdgeInsets.symmetric(
                    horizontal: size.height * 0.015,
                    vertical: size.height * 0.012),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount:
                    (state.categories.length < 6) ? state.categories.length : 6,
                itemBuilder: (context, index) {
                  final CategoryModel category = state.categories[index];
                  return CategoryCardWidget(category: category);
                });
          } else {
            return const Icon(
              Icons.error,
              color: Colors.red,
            );
          }
        },
      ),
    );
  }
}

