import 'package:flutter/material.dart';
import 'package:flutter_02_chat/routes/routes.dart';
import 'package:flutter_02_chat/services/auth_services.dart';
import 'package:provider/provider.dart';
 

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create:(_)=> AuthServices(), )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat App',
        routes:   appRoutes,
       initialRoute: 'login',
       
      ),
    );
  }
}