
// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:money_manager_application/db/category/category_db.dart';
import 'package:money_manager_application/db/category/transactions/transaction_db.dart';

import '../models/tranaction/transaction_model.dart';

class ScreenTransactions extends StatelessWidget {
   ScreenTransactions({super.key});



  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();
    CategoryDb.instance.refreshUI();


    return ValueListenableBuilder(
      valueListenable: TransactionDB.instance.transactionListNotifer,
       builder: (BuildContext ctx, List <TransactionModel> newValue, Widget? _){
        return ListView.separated(
      padding: const EdgeInsets.all(10),
      itemBuilder: (
        (contex, index) 
        {

        final _value = newValue[index];

        return  Card(
          elevation: 0,
          child:  ListTile(
            leading: CircleAvatar(
              radius: 50,
              child: Text('vfd',
              textAlign: TextAlign.center,
              ),
            ),
            title: Text('RS ${_value.amount}'),
            subtitle: Text(_value.category.name),
          ),
        );
      }),
       separatorBuilder: ((context, index) {
         return const SizedBox(height: 10);
       }
       ), 
       itemCount: newValue.length,
       ) ;
       }
       );
  }
  
}
















// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:money_manager_application/db/category/category_db.dart';
// import 'package:money_manager_application/db/category/transactions/transaction_db.dart';
// // import 'package:money_manager_application/screens/models/category/category_model.dart';
// import 'package:money_manager_application/screens/models/tranaction/transaction_model.dart';








// class ScreenTransactions extends StatelessWidget {
//   const ScreenTransactions({super.key});

//   @override
//   Widget build(BuildContext context) {
//     TransactionDB.instance.refreshUI1();
//     CategoryDb.instance.refreshUI();

     
//         return ValueListenableBuilder(
//           valueListenable: TransactionDB.instance.transactionListNotifer,
//            builder: (BuildContext ctx, List<TransactionModel> newlist, Widget? _){
//             return ListView.separated(
//           padding: EdgeInsets.all(10),


//           itemBuilder: (ctx, index) {
//            final _Transaction = newlist[index];
//             return Card(
//               elevation: 0,
//               child: ListTile(
//                 leading: CircleAvatar(
//                   radius: 50,
//                   child: Text(_Transaction.purpose,
//                   textAlign: TextAlign.center
//                   ),
//                   // backgroundColor: _value1.type == CategoryType.income
//                   // ?Colors.green
//                   // :Colors.red,
//                 ),
//                 title: Text(_Transaction.purpose),
//                 subtitle: Text(_Transaction.purpose),

//               ),
//             );
//           },
//           separatorBuilder: ((context, index) {
//             return SizedBox(height: 10);
//           }),
//           itemCount:newlist.length
//         );
//            }
//            );
//        }
   



//   }


//       // String parseDate(DateTime date){
//       // final _date = DateFormat.MMMd().format(date);
//       // final _splitedDate = _date.split('  ');
//       // return  '${_splitedDate.last}\n${_splitedDate.first}';
//       //   // return '${date.day}\n ${date.month}';
//       // }


  