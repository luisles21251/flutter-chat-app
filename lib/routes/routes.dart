import 'package:flutter/widgets.dart';
import 'package:flutter_02_chat/pages/chat_page.dart';
import 'package:flutter_02_chat/pages/loading_page.dart';
import 'package:flutter_02_chat/pages/login_page.dart';
import 'package:flutter_02_chat/pages/register_page.dart';
import 'package:flutter_02_chat/pages/user_pages.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {

  'userr': (_) => UserPage(),
  'login': (_) => LoginPage(),
  'register': (_) => RegisterPage(),
  'chat': (_) => ChatPage(),
  'loading': (_) => LoadingPage(),
};
