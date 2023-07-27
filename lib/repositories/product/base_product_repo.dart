import 'package:gromart_project/models/models.dart';

abstract class BaseProductRepository {
  Stream<List<ProductModel>> getAllProducts();
}