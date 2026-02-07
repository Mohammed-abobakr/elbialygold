import 'package:elbialygold/gold18/add_gold18.dart';
import 'package:elbialygold/gold18/gold18_dashboard.dart';
import 'package:elbialygold/gold18/home_screen.dart';
import 'package:elbialygold/gold21/gold21_dashboard.dart';
import 'package:elbialygold/homepage.dart';
import 'package:elbialygold/money/money_dashboard.dart';
import 'package:elbialygold/transfers/add_transfer.dart';
import 'package:elbialygold/transfers/transfer_dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:elbialygold/auth/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  getToken() async {
    String? myToken = await FirebaseMessaging.instance.getToken();
    print(myToken);
    print("+++++++++++++++++++");
  }

  @override
  void initState() {
    super.initState();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirebaseAuth.instance.currentUser != null ? HomeScreen() : Login(),
      theme: ThemeData(
        fontFamily: 'Tajawal',
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.amberAccent),
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(
            color: Colors.amberAccent,
            fontSize: 25,
            fontFamily: 'Tajawal',
          ),
        ),
      ),
      routes: {
        'homepage': (context) => HomePage(),
        'login': (context) => Login(),
        'homescreen': (context) => HomeScreen(),
        'addTransfer': (context) => AddTransfer(),
        'transferDashboard': (context) => TransferDashboard(),
        'moneyDashboard': (context) => MoneyDashboard(),
        'gold21Dashboard': (context) => Gold21Dashboard(),
        'gold18Dashboard': (context) => Gold18Dashboard(),
        'addGold18': (context) => AddGold18(),
      },
    );
  }
}
