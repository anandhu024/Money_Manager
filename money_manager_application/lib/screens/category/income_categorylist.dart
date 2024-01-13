import 'package:flutter/material.dart';
import 'package:money_manager_application/db/category/category_db.dart';
import 'package:money_manager_application/screens/models/category/category_model.dart';

class IncomeCategoryList extends StatelessWidget {
  const IncomeCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDb().incomeCategoryListListener, 
      builder: (BuildContext ctx, List<CateoryModel> newlist, Widget? _) {
      return ListView.separated(
      itemBuilder: (ctx, index ,){
        final _Category =newlist[index];
        return Card(
          child: ListTile(
            title: Text(_Category.name),
            trailing: IconButton(onPressed: (){
              CategoryDb.instance.deleteCategory(_Category.id);

            }, 
            icon: Icon(Icons.delete)),
          ),
        );
      },
      separatorBuilder: ((context, index) {
        return const SizedBox(height: 10);
      }), 
      itemCount: newlist.length
      );
      },
      );
  }
}