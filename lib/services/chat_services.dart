import 'package:flutter/material.dart';
import 'package:flutter_02_chat/global/enviroments.dart';
import 'package:flutter_02_chat/models/chat_response.dart';
import 'package:flutter_02_chat/services/auth_services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_02_chat/models/user.dart';



class ChatServices with ChangeNotifier {
  User ?userfor;


  Future<List<Message>> getChat(String userID) async{
    final uri = Uri.parse('${Enviroments.apiUrl}/messages/$userID');
    final token = await AuthServices.getToken();
  final resp = await http.get(uri,
  headers: {
    'Content-Type': 'application/json',
    'x-token': token!
  }

  );

  final messageResp = messagesResponseFromJson(resp.body);
  return messageResp.messages!;
  }



}
