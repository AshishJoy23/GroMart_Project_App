part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();
  
  @override
  List<Object> get props => [];
}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<CategoryModel> categories;

  const CategoryLoaded({this.categories = const <CategoryModel>[]});

  @override
  List<Object> get props => [categories];
}

class CategoryError extends CategoryState {}

