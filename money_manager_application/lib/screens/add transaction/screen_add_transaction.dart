
import 'package:flutter/material.dart';
import 'package:money_manager_application/db/category/category_db.dart';
import 'package:money_manager_application/db/category/transactions/transaction_db.dart';
import 'package:money_manager_application/screens/models/category/category_model.dart';
import 'package:money_manager_application/screens/models/tranaction/transaction_model.dart';

import '../transaction/screen_transaction.dart';

class ScreenAddTransaction extends StatefulWidget {

  static const routeName ='add-transaction';
  const ScreenAddTransaction({super.key});

  @override
  State<ScreenAddTransaction> createState() => _ScreenAddTransactionState();
}

class _ScreenAddTransactionState extends State<ScreenAddTransaction> {

  DateTime? _selectedDate;
  CategoryType? _selectedCategorytype;
  CateoryModel? _selectedCateoryModel; 

  String? _categeoryID;

  final _purposeTextEditingController = TextEditingController();
  final _amountTextEditingController = TextEditingController();

  @override
  void initState() {
    _selectedCategorytype = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            TextFormField(
              controller: _purposeTextEditingController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'PURPOSE'
              ),
            ),
            TextFormField(
              controller: _amountTextEditingController,
              keyboardType: TextInputType.number,
                decoration: InputDecoration(
                hintText: 'AMOUNT'
              ),
            ),


              
              TextButton.icon(
                onPressed: () async{
                final _selectedDatetemp= await  showDatePicker(
                    context: context, 
                    initialDate: DateTime.now(), 
                    firstDate: DateTime.now().subtract(Duration(days:30)), 
                    lastDate: DateTime.now()
                    );

                    if(_selectedDatetemp == null){
                      return;
                    }else{
                      print(_selectedDatetemp.toString());
                      setState(() {
                      _selectedDate= _selectedDatetemp;
                        
                      });
                    }
                }, 
                icon: Icon(Icons.calendar_today), 
                label: Text(_selectedDate == null ? 'Select Date' 
                :_selectedDate !.toString()
                )
                ),
                
                


                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Radio(
                              value: CategoryType.income,
                               groupValue: _selectedCategorytype,
                                onChanged: (newValue){
                                  setState(() {
                                  _selectedCategorytype =CategoryType.income;
                                  
                                  });
                                  }
                                ),
                                Text('INCOME'),
                          ],
                        ),


                          Row(
                          children: [
                            Radio(
                              value: CategoryType.expense,
                               groupValue: _selectedCategorytype,
                                onChanged: (newValue){
                                  setState(() {
                                  _selectedCategorytype =CategoryType.expense;
                                  _categeoryID =null;
                                    
                                  });
                                }
                                ),
                                Text('EXPENSE'),
                          ],
                        ),
                      ],
                    ),




DropdownButton(
  hint: Text('SELECT CATEGORY'),
  value: _categeoryID,
  items: ( _selectedCategorytype == CategoryType.income?
  CategoryDb().incomeCategoryListListener:
   CategoryDb().expenseCategoryListListener)
   .value.map((e)
  {
    return DropdownMenuItem(
      value: e.id,
      child: Text(e.name),
      onTap: () {
        _selectedCateoryModel =e;
      },
      );
  }).toList(), 
  onChanged: (selectedValue){
    // print(selectedValue);
    setState(() {
      _categeoryID = selectedValue;
    });
  }
  ),


  ElevatedButton(
    onPressed: (){
      addTransaction();
    }, 
    
    child: Text('SUBMIT'), 
    )


          ],
          ),
        )
        ),
    );

  }


  Future<void> addTransaction() async{
    final _purposeText =_purposeTextEditingController.text;
    final _amountText = _amountTextEditingController.text;
    if(_purposeText.isEmpty){
      return;
    }
    if(_amountText.isEmpty){
      return;
    }
    if(_categeoryID == null){
      return;
    }
    if(_selectedDate == null){
      return;
    }

    if(_selectedCateoryModel == null){
      return;
    }


    final _parsedAmount = double.tryParse(_amountText);
    if(_parsedAmount == null){
      return;
    }




  final _model =  TransactionModel(
      purpose: _purposeText,
       amount: _parsedAmount,
        date: _selectedDate!, 
        type: _selectedCategorytype!, 
        category: _selectedCateoryModel!
        );
        TransactionDB.instance.addTransactions(_model);
         Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => ScreenTransactions()),
  );
  }
  
}






// import 'dart:html';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:money_manager_application/db/category/category_db.dart';
// import 'package:money_manager_application/db/category/transactions/transaction_db.dart';
// import 'package:money_manager_application/screens/models/category/category_model.dart';
// import 'package:money_manager_application/screens/models/tranaction/transaction_model.dart';

// class ScreenAddTransaction extends StatefulWidget {

//   static const routeName= 'add transactions';
//   const ScreenAddTransaction({super.key});

//   @override
//   State<ScreenAddTransaction> createState() => _ScreenAddTransactionState();
// }

// class _ScreenAddTransactionState extends State<ScreenAddTransaction> {


// DateTime? _selectedDate;
// CategoryType? _selectedCategorytype;
// CateoryModel? _selectedCateoryModel;


//   String? _categeoryID;

//   final _purposeTextEditingController = TextEditingController();
//   final _amountTextEditingController = TextEditingController();

// @override
//   void initState() {
//    _selectedCategorytype = CategoryType.income; 
//     super.initState();
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
        
//             // purpose
        
        
//             TextFormField(
//               controller: _purposeTextEditingController,
//               keyboardType: TextInputType.text,
//               decoration: InputDecoration(
//                 hintText: 'Purpose',
//               ),
//             ),
        
        
//             // Amount
        
        
//             TextFormField(
//               controller: _amountTextEditingController,
//               keyboardType: TextInputType.number,
//                decoration: InputDecoration(
//                 hintText: 'Amount',
//               ),
//             ),
        
//             // Calender Date 
        
        
//             TextButton.icon(onPressed: () async{
//               final _selectedDatetemp = await showDatePicker(
//                 context: context,
//                  initialDate: DateTime.now(),
//                   firstDate: DateTime.now().subtract( const Duration(days:30)),
//                    lastDate: DateTime.now(),
//                    );
//                    if(_selectedDatetemp == null){
//                     return;
//                    }
//                    else{
//                     print(_selectedDatetemp.toString());
//                     setState(() {
//                       _selectedDate = _selectedDatetemp;
//                     });
//                    }
//             },
//              icon: Icon(Icons.calendar_today),
//               label: Text(
//                 _selectedDate == null?
//                 'Select Date': _selectedDate!.toString()
//                 ),
//               ),
        
        
//               // Radio Button
        
        
        
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Row(
//                     children: [
//                       Radio(
//                         value: CategoryType.income,
//                          groupValue: _selectedCategorytype,
//                           onChanged: (newValue){
//                             setState(() {
//                             _selectedCategorytype = CategoryType.income;
//                               _categeoryID = null;
//                             });
//                           },
//                           ),
//                           Text('income')
//                     ],
//                   ),
//                       Row(
//                         children: [
//                           Radio(
//                     value: CategoryType.expense,
//                      groupValue: _selectedCategorytype,
//                           onChanged: (newValue){
//                             setState(() {
//                             _selectedCategorytype = CategoryType.expense;
//                               _categeoryID = null;
//                             });
//                           },
//                           ),
//                           Text('expense')
        
//                         ],
//                       ),
//                 ],
//               ),
        
//               // dropdown 
        
//               DropdownButton(
//                 hint: Text('Select Category'),
//                 value: _categeoryID,
//                 items:(_selectedCategorytype == CategoryType.income
//                 ? CategoryDb().incomeCategoryListListener
//                 : CategoryDb().expenseCategoryListListener)
//                 .value.map((e) {
//                   return DropdownMenuItem(
//                     value: e.id,
//                     child: Text(e.name),
//                     onTap: (){
//                       _selectedCateoryModel = e;
//                     },
//                     );
//                 }).toList(),
//                  onChanged: (selectedValue){
//                   print(selectedValue);
//                   setState(() {
//                   _categeoryID= selectedValue;
                    
//                   });

//                  }),

//                 //  SubmitButton

//                 ElevatedButton(
//                   onPressed: (){
                    
//    Navigator.of(context).pop();
//    TransactionDB.instance.refreshUI1();
// print(TransactionDB());
//                   },
//                   child: Text('Submit')
//                     )
//           ],
//           ),
//         )
//         ),
//     );
//   }

// Future<void> addTransaction() async{
//   final _purposeText =_purposeTextEditingController.text;
//   final _amountText = _amountTextEditingController.text;
//   if(_purposeText.isEmpty){
//     return;
//   }
//   if(_amountText.isEmpty){
//     return;
//   }
//   if(_categeoryID == null){
//     return;
//   }
//   if(_selectedDate == null){
//     return;
//   }
//   if(_selectedCateoryModel == null){
//     return;
//   }

//   final _parsedAmount = double.tryParse(_amountText);
// if(_parsedAmount == null){
//   return;
// }


//  final _model = TransactionModel(
//     purpose: _purposeText, 
//     amount: _parsedAmount, 
//     date: _selectedDate!, 
//     type: _selectedCategorytype!, 
//     category: _selectedCateoryModel!,
//     );

//   TransactionDB.instance.addTransaction(_model);
   
// }

// }