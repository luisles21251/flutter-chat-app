import 'package:flutter/material.dart';
import 'package:flutter_02_chat/services/auth_services.dart';
import 'package:flutter_02_chat/services/socket_services.dart';
import 'package:flutter_02_chat/widget/custom_logo.dart';
import 'package:flutter_02_chat/widget/widget_form.dart';
import 'package:flutter_02_chat/widget/widget_label.dart';
import 'package:provider/provider.dart';
import 'package:flutter_02_chat/helpers/show_alertt.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Logo(
                  text: 'Mesenger',
                ),
                _Form(),
                Labels(
                  titulo: ' no tienes cuenta',
                  subtitulo: 'Registrate ahora',
                  ruta: 'register',
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Terminos y condiciones de uso',
                    style: TextStyle(fontWeight: FontWeight.w300, color: Colors.black, fontSize: 15),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  _Form({Key? key}) : super(key: key);

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthServices>(context);
    final socketService = Provider.of<SocketServices>(context);
    return Container(
        child: Column(
      children: [
        WidgetForm(
          icon: Icons.mail_outline,
          text: 'ingrese correo',
          keyboardType: TextInputType.emailAddress,
          textController: emailCtrl,
        ),
        WidgetForm(
          icon: Icons.remove_red_eye_outlined,
          text: 'Ingrese Password',
          textController: passCtrl,
          keyboardType: TextInputType.visiblePassword,
          isPassword: true,
        ),
        TextButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.blue), fixedSize: MaterialStateProperty.all(Size.fromWidth(150))),
            onPressed: authService.autenticando
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final loginOk = await authService.login(emailCtrl.text.trim(), passCtrl.text.trim());

                    if (loginOk) {
                      socketService.connect();
                      Navigator.pushReplacementNamed(context, 'userr');
                    } else {
                      //alerta
                      mostrarAlerta(context, 'login Incorrecto', 'revise sus credenciales nuevamente');
                    }
                  },
            child: Text(
              'ingresar',
              style: TextStyle(color: Colors.white),
            )),
      ],
    ));
  }
}
