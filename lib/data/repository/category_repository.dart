import 'package:money_manager_app/data/model/category/category.dart';
import 'package:money_manager_app/service/remote/category.dart';

class CategoryRepository {
  final CategoryService categoryService;
  CategoryRepository({required this.categoryService});

  Future<List<Category>> getCategoryData() async {
    return await categoryService.getCategoryData();
  }
}
