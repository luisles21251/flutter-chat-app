import 'package:flutter_02_chat/global/enviroments.dart';
import 'package:flutter_02_chat/models/user.dart';
import 'package:flutter_02_chat/models/users_response.dart';
import 'package:flutter_02_chat/services/auth_services.dart';
import 'package:http/http.dart' as http;

class UsersServices {
  Future<List<User>> getUsers() async {
    try {
      final uri = Uri.parse('${Enviroments.apiUrl}/user/');
      final token = await AuthServices.getToken();
      final resp = await http.get(uri, headers: {'Content-Type': 'application', 'x-token': token!});

      final usersResponse = usersListResponseFromJson(resp.body);
      return usersResponse.users!.toList();
    } catch (error) {
      print('caimos al error en user services');
      return [];
    }
  }
}
