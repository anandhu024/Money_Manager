

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_application/screens/models/tranaction/transaction_model.dart';

const TRANSACTION_DB_NAME = 'Transaction-db';



abstract class TransactionDbFunctions{
 Future<void> addTransactions(TransactionModel obj);
Future <List<TransactionModel>> getTransaction();
}



class TransactionDB implements TransactionDbFunctions{

TransactionDB._internal();

  static TransactionDB instance = TransactionDB._internal();

  factory TransactionDB(){
     return instance;
  }

  ValueNotifier<List<TransactionModel>> transactionListNotifer =ValueNotifier([]);


  @override
  Future<void> addTransactions(TransactionModel obj) async{
   final _db =await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
   await _db.put(obj.id, obj);
  }


  Future<void> refresh() async{
    final _list =await getTransaction();
    transactionListNotifer.value.clear();
    transactionListNotifer.value.addAll(_list);
    transactionListNotifer.notifyListeners();
  }
  
  @override
  Future<List<TransactionModel>> getTransaction() async{
    final db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
   return db.values.toList();
  }
   

}






// import 'package:flutter/foundation.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:money_manager_application/screens/models/tranaction/transaction_model.dart';

// const TRANSACTION_DB_NAME= 'transaction-db';


// // 
// //
// //
// //
// //
// //
// //
// //
// //to get the data first create a future list in abstract class
// // then adding the missing override Function usung the implements functions
// //then create a value notifer Function
// // then create a refresh function for recalling and refreshing the data
// // then goes to the screen page 
// //
// //
// //
// //
// //
// //






// abstract class TransactionDbFunctions{
//  Future <void> addTransaction(TransactionModel obj);
//  Future <List<TransactionModel>> allTransaction();
// }

// class TransactionDB implements TransactionDbFunctions{
// TransactionDB._internal();

// static TransactionDB instance =TransactionDB._internal();


// factory TransactionDB(){
//   return instance;
// }


// ValueNotifier<List<TransactionModel>> 
// transactionListNotifer =ValueNotifier([]);

//   @override
//   Future<void> addTransaction(TransactionModel obj) async {
//    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
//  await _db.put(obj.id, obj);

//   }

// Future<void> refreshUI1() async{
//   final _list = await allTransaction();
//   _list.sort((first,second)=> second.date.compareTo(first.date));
//   transactionListNotifer.value.clear();
//   transactionListNotifer.notifyListeners();

//   transactionListNotifer.value.addAll(_list);
// }

//   @override
//   Future<List<TransactionModel>> allTransaction() async {
//    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
//    return _db.values.toList();
//   }

  
  

// }