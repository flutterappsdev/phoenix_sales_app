import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import './screen/daily_expenses_screen.dart';
import './screen/menu_sales_screen.dart';
import './screen/login_screen.dart';
import 'screen/tr_entry_screen.dart';
import './screen/menu_screen.dart';
import './screen/List_tr_data.dart';
import './screen/supply_entry_screen.dart';
import './screen/List_dm_data.dart';
import './screen/imgae_upload_screen.dart';
import './screen/trip_screen.dart';
import './screen/chicks_deamand_screen.dart';
import './screen/daily_expenses_screen.dart';
import './screen/List_demand_data.dart';
import './screen/List_expense_data.dart';
import './screen/List_tr_customer.dart';
import './screen/List_dm_customer.dart';
import './screen/Pdf_tr.dart';
import './screen/Pdf_dm.dart';
import './screen/splashscreenforapp.dart';
import './screen/MyLoginScreen.dart';
import './screen/new_customer_add.dart';
import './screen/List_new_farmer.dart';
 Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phoenix Sales',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'NamBold',
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.black
          )
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreenForApp(),
      routes: {
        SalesMenuGrid.id : (context)=>SalesMenuGrid(),
        TrEntryScreen.id : (context)=>TrEntryScreen(),
        ListTrData.id :(context)=>ListTrData(),
        SupplyEntryScreen.id : (context)=>SupplyEntryScreen(),
        ListDmData.id : (context)=>ListDmData(),
        ImageUploadScreen.id : (context)=>ImageUploadScreen(),
        TripScreen.id : (context)=>TripScreen(),
        ChicksDemandScreen.id :(context)=>ChicksDemandScreen(),
        DailyExpensesScreen.id : (context)=>DailyExpensesScreen(),
        ListDemadData.id :(context)=>ListDemadData(),
        ListExpenseData.id : (context)=>ListExpenseData(),
        ListTrCustomer.id :(context)=>ListTrCustomer(),
        ListDmCustomer.id :(context)=>ListDmCustomer(),
        PdfTr.id : (context)=>PdfTr(),
        PdfDm.id :(context)=>PdfDm(),
        NewCustomeradd.id: (context)=>NewCustomeradd(),
        ListNewCustomer.id : (context)=>ListNewCustomer(),
      },
    );
  }
}
