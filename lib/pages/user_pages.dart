import 'package:flutter/material.dart';
import 'package:flutter_02_chat/models/user.dart';
import 'package:flutter_02_chat/services/auth_services.dart';
import 'package:flutter_02_chat/services/chat_services.dart';
import 'package:flutter_02_chat/services/socket_services.dart';
import 'package:flutter_02_chat/services/users_services.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final usersServices = UsersServices();
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  List<User> users = [];

  @override
  void initState() {
    this._userLoading();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authservices = Provider.of<AuthServices>(context);
    final socketService = Provider.of<SocketServices>(context);
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
              socketService.disconnect();
              Navigator.pushReplacementNamed(context, 'login');
              AuthServices.deletedToken();
            },
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 10),
              child: (socketService.serverStatus == ServerStatus.Online)
                  ? Icon(Icons.check_circle, color: Colors.green)
                  : Icon(
                      Icons.cancel_outlined,
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
      onTap: () {
        final chatServices = Provider.of<ChatServices>(context, listen: false);
        chatServices.userfor = users;
        Navigator.pushNamed(context, 'chat');
      },
    );
  }

  _userLoading() async {
    this.users = await usersServices.getUsers();
    setState(() {});

    //await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
