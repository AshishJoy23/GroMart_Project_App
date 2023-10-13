import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/blocs/blocs.dart';

class CustomAppBarWidget extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final bool isLeading;
  final bool isSearch;
  final List<Widget> actionList;
  const CustomAppBarWidget({
    super.key,
    required this.title,
    required this.actionList,
    this.isLeading = true,
    this.isSearch = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: (isLeading)
          ? IconButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (isSearch) {
                  BlocProvider.of<SearchBloc>(context)
                      .add(const SearchCleared());
                }
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 26,
              ),
            )
          : const SizedBox(),
      elevation: 0,
      centerTitle: true,
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      actions: actionList,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
