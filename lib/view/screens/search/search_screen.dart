import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/blocs/blocs.dart';
import 'package:gromart_project/view/config/colors.dart';
import 'package:gromart_project/view/widgets/widgets.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  static const String routeName = '/search';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const SearchScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController searchedQuery = TextEditingController();
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: const CustomAppBarWidget(
        title: 'Search',
        actionList: [],
        isSearch: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
          child: Column(
            children: [
              TextField(
                controller: searchedQuery,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: kCardColor,
                  contentPadding: const EdgeInsets.all(10),
                  disabledBorder: InputBorder.none,
                  focusedBorder: const OutlineInputBorder(
                    gapPadding: 0.0,
                    borderSide: BorderSide(color: kPrimaryColor),
                  ),
                  prefixIcon: const Icon(
                    CupertinoIcons.search,
                    size: 30,
                    color: kPrimaryColor,
                  ),
                  suffixIcon: InkWell(
                    onTap: () {
                      searchedQuery.clear();
                      BlocProvider.of<SearchBloc>(context)
                          .add(const SearchCleared());
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    child: const Icon(
                      Icons.clear,
                      color: kIconColor,
                    ),
                  ),
                  hintText: 'Search Here...',
                  hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                ),
                onChanged: (value) {
                  log('<<<<<<serached query>>>>>>');
                  log(value);
                  BlocProvider.of<SearchBloc>(context)
                      .add(ProductSearched(searchedQuery: value));
                },
                onTapOutside: (_) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
              ),
              BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        backgroundColor: Colors.white,
                        color: Colors.black,
                      ),
                    );
                  } else if (state is SearchLoaded) {
                    log('<<<<<<<<<------------>>>>>>>>>');
                    log('<<<<<image condition>>>>>');
                    log(state.isSearching.toString());
                    return (state.suggestionList.isEmpty)
                        ? ((state.isSearching && searchedQuery.text.isNotEmpty)
                            ? const EmptyScreenWidget(
                                emptyMsg: 'Item Not Found!',
                                imageUrl: 'assets/images/no_data.png')
                            : const EmptyScreenWidget(
                                emptyMsg: 'Search What You Love!',
                                imageUrl: 'assets/images/search_item.png'))
                        : GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.03,
                                vertical: size.width * 0.01),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.7,
                              mainAxisSpacing: size.width * 0.05,
                              crossAxisSpacing: size.width * 0.03,
                            ),
                            itemCount: state.suggestionList.length,
                            itemBuilder: (context, index) {
                              return ProductCardWidget(
                                  product: state.suggestionList[index]);
                            },
                          );
                  } else {
                    return const Icon(
                      Icons.error,
                      color: Colors.red,
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const MainBottomNavBar(),
    );
  }
}
