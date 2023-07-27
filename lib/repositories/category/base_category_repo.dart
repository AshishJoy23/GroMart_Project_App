import 'package:gromart_project/models/models.dart';

abstract class BaseCategoryRepository {
  Stream<List<CategoryModel>>  getAllCategories();
}