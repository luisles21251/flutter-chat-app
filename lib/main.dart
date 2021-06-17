import 'package:flutter/material.dart';
import 'package:flutter_02_chat/routes/routes.dart';
import 'package:flutter_02_chat/services/auth_services.dart';
import 'package:flutter_02_chat/services/chat_services.dart';
import 'package:flutter_02_chat/services/socket_services.dart';
import 'package:provider/provider.dart';
 

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create:(_)=> AuthServices(), ),
        ChangeNotifierProvider(create:(_)=> SocketServices(), ),
        ChangeNotifierProvider(create: (_)=> ChatServices(),  )
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