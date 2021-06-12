import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

 mostrarAlerta(BuildContext context, String titulo, String subtitulo) {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: Text(titulo),
            content: Text(subtitulo),
            actions: [MaterialButton(elevation: 3, child: Text('OK'), onPressed: () => Navigator.pop(context))],
          ));
}