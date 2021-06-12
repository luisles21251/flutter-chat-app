import 'package:flutter/material.dart';
import 'package:flutter_02_chat/models/user.dart';
import 'package:flutter_02_chat/services/auth_services.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  final users = [
    User(
      uid: '1',
      nombre: 'maria',
      email: 'text1@text.com',
      online: true,
    ),
    User(
      uid: '2',
      nombre: 'manuel',
      email: 'text1@text.com',
      online: true,
    ),
    User(
      uid: '3',
      nombre: 'javier',
      email: ' text1@text.com',
      online: true,
    )
  ];

  @override
  Widget build(BuildContext context) {
    final authservices = Provider.of<AuthServices>(context);
    final user = authservices.user;

    return Scaffold(
        appBar: AppBar(
          title: Text(
           ' ${user?.nombre}',
            style: TextStyle(color: Colors.blue),
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.black,
            ),
            onPressed: () {
              //TODO: desconectarnos de socket

              Navigator.pushReplacementNamed(context, 'login');
              AuthServices.deletedToken();
            },
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 10),
              // child: Icon(Icons.check_circle, color: colors.green),
              child: Icon(
                Icons.check_circle,
                color: Colors.red,
              ),
            )
          ],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: _userLoading,
          header: WaterDropHeader(
            complete: Icon(Icons.check, color: Colors.blue[400]),
            waterDropColor: Colors.grey,
          ),
          child: _listViewUser(),
        ));
  }

  ListView _listViewUser() {
    return ListView.separated(
      itemBuilder: (_, i) => _usersListTile(users[i]),
      separatorBuilder: (_, i) => Divider(),
      itemCount: users.length,
    );
  }

  ListTile _usersListTile(User users) {
    return ListTile(
      title: Text('${users.nombre}'),
      subtitle: Text('${users.email}'),
      leading: CircleAvatar(
        backgroundColor: Colors.blueAccent[100],
        child: Text(
          users.nombre!.substring(0, 2),
          style: TextStyle(color: Colors.white),
        ),
      ),
      trailing: Container(
        height: 10,
        width: 10,
        decoration: BoxDecoration(color: users.online == true ? Colors.green : Colors.grey, borderRadius: BorderRadius.circular(100)),
      ),
    );
  }

  _userLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
