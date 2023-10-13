import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/blocs/blocs.dart';
import 'package:gromart_project/models/models.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ProductBloc _productBloc;
  SearchBloc({required ProductBloc productBloc})
      : _productBloc = productBloc,
        super(SearchLoading()) {
    on<ProductSearched>(_onProductSearched);
    on<SearchCleared>(_onSearchCleared);
  }

  void _onProductSearched(
      ProductSearched event, Emitter<SearchState> emit) async {
    log('<<<<<<<<<search bloc code>>>>>>>>>');

    //emit(SearchLoading());
    try {
      await Future<void>.delayed(const Duration(milliseconds: 200));
      if (_productBloc.state is ProductLoaded) {
        final List<ProductModel> suggestionList =
            (_productBloc.state as ProductLoaded)
                .products
                .where((product) => product.name
                    .toLowerCase()
                    .contains(event.searchedQuery.toLowerCase()))
                .toList();
        log('<<<<<searching>>>>>');
        log(suggestionList.toString());
        emit(
          SearchLoaded(
            suggestionList: suggestionList,
            isSearching: true,
          ),
        );
      } else {
        emit(
          const SearchLoaded(
            suggestionList: [],
            isSearching: false,
          ),
        );
      }

      log('search loaded successfully');
    } catch (e) {
      log('Something went wrong: $e');
    }
  }

  void _onSearchCleared(SearchCleared event, Emitter<SearchState> emit) {
    emit(
      const SearchLoaded(
        suggestionList: [],
        isSearching: false,
      ),
    );
  }
}
