import 'package:flutter/material.dart';
import 'package:mysnap_app/pages/home_page.dart';
import 'package:mysnap_app/pages/login_page.dart';
import 'package:mysnap_app/pages/register_page.dart';

void main() {
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
