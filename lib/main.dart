import 'package:flutter/material.dart';
import 'package:flutter_02_chat/routes/routes.dart';
 

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      routes:   appRoutes,
     initialRoute: 'login',
     
    );
  }
}