import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_02_chat/global/enviroments.dart';
import 'package:flutter_02_chat/models/login_response.dart';
import 'package:flutter_02_chat/models/user.dart';
import 'package:http/http.dart' as http;

class AuthServices with ChangeNotifier {
  User? user;
  bool _autenticando = false;
  final _storage = FlutterSecureStorage();

  bool get autenticando => this._autenticando;
  set autenticando(bool valor) {
    this._autenticando = valor;
    notifyListeners();
  }

  //acceder al token
  static Future<String?> getToken() async {
    final _storage = FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  //eliminar token
  static Future<void> deletedToken() async {
    final _storage = FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    this.autenticando = true;

    final data = {'email': email, 'password': password};

    final uri = Uri.parse('${Enviroments.apiUrl}/login/');

    final resp = await http.post(uri, body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    
    this.autenticando = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.user = loginResponse.user;

      //guardar toquen en lugar seguro
      await this._guardarToken(loginResponse.token!);

      return true;
    } else {
      return false;
    }
  }

  Future register(String nombre, String email, String password) async {
    this.autenticando = true;

    final data = {'nombre': nombre, 'email': email, 'password': password};

    final uri = Uri.parse('${Enviroments.apiUrl}/login/new/');

    final resp = await http.post(uri, body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    
    this.autenticando = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.user = loginResponse.user;

      //guardar toquen en lugar seguro
      await this._guardarToken(loginResponse.token!);

      return true;
    } else {
      final rspBody = jsonDecode(resp.body);
      return rspBody['msg'];
    }
  }

  Future<bool?> isLoggedIn() async {
    final token = await this._storage.read(key: 'token');
  
    final uri = Uri.parse('${Enviroments.apiUrl}/login/renew/');
    final resp = await http.get(uri, headers: {'Content-Type': 'application/json', 'x-token': token!});

    
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.user = loginResponse.user;

      //guardar toquen en lugar seguro
      await this._guardarToken(loginResponse.token!);

      return true;
    } else {
      this.logout();
      return false;
    }
  }

  Future _guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }
}
