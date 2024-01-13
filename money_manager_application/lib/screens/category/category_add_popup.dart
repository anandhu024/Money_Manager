import 'dart:js';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:money_manager_application/db/category/category_db.dart';
import 'package:money_manager_application/screens/models/category/category_model.dart';

ValueNotifier<CategoryType>
 selectedCategorynotifer = ValueNotifier(CategoryType.income);


Future<void>showCategoryAddPopup( BuildContext context) async{

  final _nameEditController = TextEditingController();

  showDialog(
    context: context,
     builder: (ctx){
     return SimpleDialog(
      title: const Text('Add Category'),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _nameEditController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Category Name',
            ),
          ),
        ),

          Padding(
          padding: const EdgeInsets.all(8.0),
            child: Row(
            children: [
              RadioButton(title: 'income', type: CategoryType.income),
              RadioButton(title: 'expense', type: CategoryType.expense)
            ],
          )),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: (){
              final _name = _nameEditController.text;
              if(_name.isEmpty){
                return;
              }

              final _type= selectedCategorynotifer.value;
             final _category = CateoryModel(
              id: DateTime.now().millisecondsSinceEpoch.toString(), 
              name: _name, 
              type: _type,
              );

              CategoryDb().insertCategory(_category);
              Navigator.of(ctx).pop();

            }, 
          child: Text('Add')),
        )
      ],
     ) ;
      
     }
     );
}

class RadioButton extends StatelessWidget {

  final String title;
  final CategoryType type;


  const RadioButton({Key? key,
  required this.title,
  required this.type,

  }):super(key: key);



  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
       ValueListenableBuilder(
        valueListenable: selectedCategorynotifer,
         builder: (BuildContext ctx, CategoryType newCategory, Widget? _){
        return   Radio<CategoryType>(
          value: type,
           groupValue: newCategory,
            onChanged: (value){
              if(value == null){
                return;
              }

             selectedCategorynotifer.value = value;
             selectedCategorynotifer.notifyListeners();
            }
            );
         }),
        Text(title),
      ],
    );
  }
}