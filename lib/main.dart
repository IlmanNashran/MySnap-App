import 'package:flutter/material.dart';
import 'package:mysnap_app/pages/home_page.dart';
import 'package:mysnap_app/pages/login_page.dart';
import 'package:mysnap_app/pages/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:mysnap_app/pages/services/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //initilize first
  await Firebase.initializeApp(); //before execute the initializeApp need to initilize
  GetIt.instance.registerSingleton<FirebaseService>(FirebaseService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Snap App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: 'home', //first route auto
      routes: {
        'register': (context) => RegisterPage(),
        'login': (context) => LoginPage(),
        'home': (context) => HomePage(),
      },
    );
  }
}
