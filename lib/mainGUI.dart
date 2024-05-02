import 'package:store/screens/product_list_screen.dart';
import 'package:store/screens/user_data.dart';
import 'package:store/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "Master Fitness",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
    home: SplashScreen(),
    );
  }
}