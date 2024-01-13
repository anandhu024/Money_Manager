import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_application/screens/models/category/category_model.dart';


const CATEGORY_DB_NAME ='category-database';

abstract class CategoryDbFunctions{
 Future< List<CateoryModel>>getCategory();
Future <void> insertCategory(CateoryModel values);
Future <void> deleteCategory (String categoryID);
}


class CategoryDb implements CategoryDbFunctions{

  
  // single ton Function

  CategoryDb.internal();
  static CategoryDb instance =CategoryDb.internal();

  factory CategoryDb(){
    return instance;
  }


//////////////

    ValueNotifier<List<CateoryModel>> incomeCategoryListListener =ValueNotifier([]); 
    ValueNotifier<List<CateoryModel>> expenseCategoryListListener =ValueNotifier([]); 
  
  @override
  Future<void> insertCategory(CateoryModel values) async {

   final _categeoryDB =await Hive.openBox<CateoryModel>(CATEGORY_DB_NAME);
  await _categeoryDB.put(values.id,values);
  refreshUI();
  }
  
  @override
 Future<List<CateoryModel>> getCategory() async {
    final _categeoryDB =await Hive.openBox<CateoryModel>(CATEGORY_DB_NAME);
  return _categeoryDB.values.toList();
  }

  Future<void> refreshUI() async{
    final _allCategories = await getCategory();
    incomeCategoryListListener.value.clear();
    expenseCategoryListListener.value.clear();
    Future.forEach(_allCategories, (CateoryModel category) {
      if(category.type == CategoryType.income){
        incomeCategoryListListener.value.add(category);
      }else{
        expenseCategoryListListener.value.add(category);
      }
    });
incomeCategoryListListener.notifyListeners();
expenseCategoryListListener.notifyListeners();

  }
  
  @override
  Future<void> deleteCategory(String categoryID) async {
   final _categeoryDB =await Hive.openBox<CateoryModel>(CATEGORY_DB_NAME);
   await _categeoryDB.delete(categoryID);
   refreshUI();
  }

}