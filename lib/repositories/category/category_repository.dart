import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gromart_project/models/category_model.dart';
import 'package:gromart_project/repositories/category/base_category_repo.dart';

class CategoryRepository extends BaseCategoryRepository {
  final FirebaseFirestore _firebaseFirestore;

  CategoryRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance; //

  @override
  Stream<List<CategoryModel>> getAllCategories() {
    return _firebaseFirestore
        .collection('categories')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => CategoryModel.fromSnapshot(doc))
          .toList();
    });
  }
}
