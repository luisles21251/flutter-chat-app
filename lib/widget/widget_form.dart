import 'package:flutter/material.dart';

class WidgetForm extends StatelessWidget {
  final IconData? icon;
  final String? text;
  final TextEditingController? textController;
  final TextInputType? keyboardType;
  final bool isPassword;

  const WidgetForm({Key? key, @required this.icon, @required this.text, @required this.textController, this.keyboardType= TextInputType.text, this.isPassword= false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.only(left: 5, top: 5, bottom: 5, right: 15),
      width: 300,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25.0), boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          offset: Offset(0, 5),
          blurRadius: 5,
        )
      ]),
      child: TextField(
        obscureText: this.isPassword,
        controller: textController,
        autocorrect: false,
        keyboardType: this.keyboardType,
        decoration: InputDecoration(
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          prefixIcon: Icon(icon),
          labelText: text,
        ),
      ),
    );
  }
}
