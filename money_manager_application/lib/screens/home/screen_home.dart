import 'package:flutter/material.dart';
import 'package:money_manager_application/db/category/category_db.dart';
import 'package:money_manager_application/screens/add%20transaction/screen_add_transaction.dart';
import 'package:money_manager_application/screens/category/category_add_popup.dart';
import 'package:money_manager_application/screens/category/screen_category.dart';
import 'package:money_manager_application/screens/home/widgets/bottom_navigation.dart';
import 'package:money_manager_application/screens/models/category/category_model.dart';
import 'package:money_manager_application/screens/transaction/screen_transaction.dart';

class ScreenHome extends StatelessWidget {
   ScreenHome({super.key});

  static ValueNotifier<int> selectedIndexNotifier =ValueNotifier(0);

  final _pages=  [
    ScreenTransactions(),

    ScreenCategory(),
    

  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey[400],

      appBar: AppBar(
        title: Text('MONEY MANAGER'),
        backgroundColor: Colors.amberAccent,
        centerTitle:  true,
      ),


      // navigation in seperate page in single click

      bottomNavigationBar: moneymanagerBottomNavigationBar(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedIndexNotifier,
          builder: (BuildContext context,int updatedIndex, _) {
            return _pages[updatedIndex];
          },)
        ),

    // adding button in seperate pages


        floatingActionButton: FloatingActionButton(
          onPressed: (){
            if(selectedIndexNotifier.value ==0){
              print('Add Transaction');
              Navigator.of(context).pushNamed(ScreenAddTransaction.routeName);
            }else
            {
            print('Add category');
            showCategoryAddPopup(context);

            // final _sample = CateoryModel(
            //   id: DateTime.now().millisecondsSinceEpoch.toString(),
            //  name: 'Travel', 
            // type: CategoryType.expense
            // );
            // CategoryDb().insertCategory(_sample);
            }
          },
            child:Icon(Icons.add),
          ),
    );
  }
}