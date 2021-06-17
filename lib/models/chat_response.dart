// To parse this JSON data, do
//
//     final messagesResponse = messagesResponseFromJson(jsonString);

import 'dart:convert';

MessagesResponse messagesResponseFromJson(String str) => MessagesResponse.fromJson(json.decode(str));

String messagesResponseToJson(MessagesResponse data) => json.encode(data.toJson());

class MessagesResponse {
  MessagesResponse({
    this.ok,
    this.messages,
  });

  bool? ok;
  List<Message>? messages;

  factory MessagesResponse.fromJson(Map<String, dynamic> json) => MessagesResponse(
    ok: json["ok"],
    messages: List<Message>.from(json["messages"].map((x) => Message.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ok": ok,
    "messages": List<dynamic>.from(messages!.map((x) => x.toJson())),
  };
}

class Message {
  Message({
    this.by,
    this.messageFor,
    this.mensaje,
    this.createdAt,
    this.updatedAt,
  });

  String? by;
  String? messageFor;
  String? mensaje;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    by: json["by"],
    messageFor: json["for"],
    mensaje: json["mensaje"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "by": by,
    "for": messageFor,
    "mensaje": mensaje,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
