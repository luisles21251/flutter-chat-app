import 'package:flutter/material.dart';
import 'package:flutter_02_chat/models/chat_response.dart';
import 'package:flutter_02_chat/services/auth_services.dart';
import 'package:flutter_02_chat/services/chat_services.dart';
import 'package:flutter_02_chat/services/socket_services.dart';
import 'package:flutter_02_chat/widget/chat_message.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();

  ChatServices? chatServices;
  SocketServices? socketServices;
  AuthServices? authServices;

  List<ChatMessage> _messages = [];

  bool _estaEscribiendo = false;

  @override
  void initState() {
    super.initState();

    this.chatServices = Provider.of<ChatServices>(context, listen: false);
    this.socketServices = Provider.of<SocketServices>(context, listen: false);
    this.authServices = Provider.of<AuthServices>(context, listen: false);

    this.socketServices?.socket.on('mensaje-personal', _listenMessage);
    _loadHistory('${this.chatServices?.userfor?.uid}');


  }
  void _loadHistory( String userID)async{


  List<Message> chat = await this.chatServices!.getChat(userID);
  final history = chat.map((e) => ChatMessage(
      text:e.mensaje,
      uid:e.by,
      animationController:AnimationController(vsync:this, duration: Duration(milliseconds: 0) )..forward(),));

    setState(() {
      _messages.insertAll(0, history);
    });

  }


  void _listenMessage(dynamic payload) {
    ChatMessage message = ChatMessage(text: payload['mensaje'], uid: payload['by'], animationController: AnimationController(vsync: this, duration: Duration(milliseconds: 300)));

    setState(() {
      _messages.insert(0, message);
    });

    message.animationController!.forward();
  }

  @override
  Widget build(BuildContext context) {
    final userFor = chatServices!.userfor;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: <Widget>[
            CircleAvatar(
              child: Text(userFor!.nombre!.substring(0, 2), style: TextStyle(fontSize: 12)),
              backgroundColor: Colors.blue[100],
              maxRadius: 14,
            ),
            SizedBox(height: 3),
            Text(userFor.nombre!, style: TextStyle(color: Colors.black87, fontSize: 12))
          ],
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
                child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: _messages.length,
              itemBuilder: (_, i) => _messages[i],
              reverse: true,
            )),

            Divider(height: 1),

            // todo: Caja de tex
            Container(
              color: Colors.white,
              child: _inputChat(),
            )
          ],
        ),
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
              child: TextField(
            controller: _textController,
            onSubmitted: _handleSubmit,
            onChanged: (texto) {
              setState(() {
                if (texto.trim().length > 0) {
                  _estaEscribiendo = true;
                } else {
                  _estaEscribiendo = false;
                }
              });
            },
            decoration: InputDecoration.collapsed(hintText: 'Enviar mensaje'),
            focusNode: _focusNode,
          )),

          // Botón de enviar

          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            child: IconTheme(
              data: IconThemeData(color: Colors.blue[400]),
              child: IconButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                icon: Icon(Icons.send),
                onPressed: _estaEscribiendo ? () => _handleSubmit(_textController.text.trim()) : null,
              ),
            ),
          )
        ],
      ),
    ));
  }

  _handleSubmit(String texto) {
    if (texto.length == 0) return;

    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = new ChatMessage(
      uid: authServices?.user?.uid,
      text: texto,
      animationController: AnimationController(vsync: this, duration: Duration(milliseconds: 200)),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController!.forward();

    setState(() {
      _estaEscribiendo = false;
    });

    this.socketServices!.emit('mensaje-personal', {'by': this.authServices!.user!.uid, 'for': this.chatServices!.userfor!.uid, 'mensaje': texto});
  }

  @override
  void dispose() {
  

    for (ChatMessage message in _messages) {
      message.animationController!.dispose();
    }
    this.socketServices?.socket.off('mensaje-personal');
    super.dispose();
  }
}
  