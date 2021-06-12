import 'package:flutter/material.dart';
import 'package:flutter_02_chat/pages/login_page.dart';
import 'package:flutter_02_chat/pages/user_pages.dart';
import 'package:flutter_02_chat/services/auth_services.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: checkLoginState(context),
          builder: (context, snapShot) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //CircularProgressIndicator(),
                Text('autenticando...'),
              ],
            ));
          },
        ),
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authServices = Provider.of<AuthServices>(context, listen: false);

    final autenticado = await authServices.isLoggedIn();
    print('a punto de entrar a la condicion');
    if (autenticado ==true ) {
      Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (_, __, ___) => UserPage(), transitionDuration: Duration(milliseconds: 0)));
    } else {
      Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (_, __, ___) => LoginPage(), transitionDuration: Duration(milliseconds: 0)));
    }
  }
}
