import 'package:flutter/material.dart';
import 'package:flutter_02_chat/helpers/show_alertt.dart';
import 'package:flutter_02_chat/services/auth_services.dart';
import 'package:flutter_02_chat/widget/custom_logo.dart';
import 'package:flutter_02_chat/widget/widget_form.dart';
import 'package:flutter_02_chat/widget/widget_label.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
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
    final authServices = Provider.of<AuthServices>(context);
    return Container(
        child: Column(
      children: [
        WidgetForm(
          icon: Icons.perm_identity,
          text: 'ingrese su nombre',
          textController: nameCtrl,
        ),
        WidgetForm(
          icon: Icons.mail_outline,
          text: 'Ingrese su Email',
          textController: emailCtrl,
          keyboardType: TextInputType.emailAddress,
        ),
        WidgetForm(
          icon: Icons.remove_red_eye_outlined,
          text: 'ingrese contraseña',
          textController: pssCtrl,
          keyboardType: TextInputType.visiblePassword,
          isPassword: true,
        ),
        TextButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.blue), fixedSize: MaterialStateProperty.all(Size.fromWidth(150))),
            onPressed: authServices.autenticando
                ? null
                : () async {
                    print(nameCtrl.text);
                    print(emailCtrl.text);
                    print(pssCtrl.text);
                    final registerOK = await authServices.register(nameCtrl.text.trim(), emailCtrl.text.trim(), pssCtrl.text.trim());

                    if (registerOK== true) {
                      //connectar al socket server
                      Navigator.pushReplacementNamed(context, 'userr');
                    } else {
                      mostrarAlerta(context, 'Registro incorrecto', registerOK);
                    }
                  },
            child: Text(
              'Registrarse',
              style: TextStyle(color: Colors.white),
            )),
      ],
    ));
  }
}
