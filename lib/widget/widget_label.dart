import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String? titulo;
  final String? subtitulo;
  final String? ruta;

  const Labels({Key? key, this.titulo, this.subtitulo, this.ruta}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      child: Column(children: [
        Text(
          '¿$titulo?',
          style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300),
        ),
        SizedBox(
          height: 8,
        ),
        TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '$ruta');
            },
            child: Text(
              subtitulo!,
              style: TextStyle(fontSize: 15, color: Colors.blue[600], fontWeight: FontWeight.bold),
            )),
      ]),
    );
  }
}
