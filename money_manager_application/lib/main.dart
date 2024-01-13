import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_application/screens/add%20transaction/screen_add_transaction.dart';
import 'package:money_manager_application/screens/home/screen_home.dart';
import 'package:money_manager_application/screens/models/category/category_model.dart';
import 'package:money_manager_application/screens/models/tranaction/transaction_model.dart';

Future <void> main() async{
WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

    if(!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId))
  {
    Hive.registerAdapter(CategoryTypeAdapter());
  }

  if(!Hive.isAdapterRegistered(CateoryModelAdapter().typeId))
  {
    Hive.registerAdapter(CateoryModelAdapter());
  }

   if(!Hive.isAdapterRegistered(TransactionModelAdapter().typeId))
  {
    Hive.registerAdapter(TransactionModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ScreenHome(),
      routes: {
        ScreenAddTransaction.routeName:(ctx)=> const ScreenAddTransaction()
      },
      );
  }
}

