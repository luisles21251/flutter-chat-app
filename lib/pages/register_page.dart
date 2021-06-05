import 'package:flutter/material.dart';
import 'package:flutter_02_chat/widget/custom_logo.dart';
import 'package:flutter_02_chat/widget/widget_form.dart';
import 'package:flutter_02_chat/widget/widget_label.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Logo(
              text: 'Registrarse',
            ),
            _FormR(),
            Labels(
              titulo: 'ya tienes cuenta',
              subtitulo: 'inicia sesion',
              ruta: 'login',
            )
          ],
        ),
      ),
    );
  }
}

class _FormR extends StatefulWidget {
  _FormR({Key? key}) : super(key: key);

  @override
  _FormRState createState() => _FormRState();
}

class _FormRState extends State<_FormR> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final pssCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        WidgetForm(
        icon: Icons.perm_identity,
        text: 'ingrese su nombre', 
        textController: nameCtrl),
         WidgetForm(
           icon: Icons.mail_outline,
            text: 'Ingrese su Email',
             textController: emailCtrl),
              WidgetForm(icon: Icons.remove_red_eye_outlined,
               text: 'ingrese contraseña',
                textController:pssCtrl),
            TextButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.blue), fixedSize: MaterialStateProperty.all(Size.fromWidth(150))),
            onPressed: () {
              print(emailCtrl.text);
            },child: Text(
              'Registrarse',
              style: TextStyle(color: Colors.white),
            )),

                
      ],
    ));
  }
}
