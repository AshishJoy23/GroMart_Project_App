part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class ProductSearched extends SearchEvent {
  final String searchedQuery;

  const ProductSearched({required this.searchedQuery});
  @override
  List<Object> get props => [searchedQuery];
}

class SearchCleared extends SearchEvent {

  const SearchCleared();
  @override
  List<Object> get props => [];
}
