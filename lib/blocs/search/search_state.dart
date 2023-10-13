part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<ProductModel> suggestionList;
  final bool isSearching;

  const SearchLoaded(
      {this.suggestionList = const [], this.isSearching = false});

  @override
  List<Object> get props => [suggestionList];
}

class SearchError extends SearchState {}
