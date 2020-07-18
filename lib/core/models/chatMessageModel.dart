import 'package:corona_chat_bot/core/enum/messagetype.dart';

class ChatMessageModel {
  ChatMessageModel({
    this.fromBot,
    this.type,
    this.message,
    this.path,
    this.isLocal,
    this.duration,
  });

  bool fromBot;
  MessageType type;
  String message;
  String path;
  bool isLocal;
  int duration;

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) => ChatMessageModel(
    fromBot: json["fromBot"] as bool,
    type: json["type"] as String == "Audio" ? MessageType.Audio : MessageType.Text,
    message: json["message"] as String,
    path: json["path"] as String,
    isLocal: json["isLocal"] as bool,
    duration:json["duration"] as int,
  );

  Map<String, dynamic> toJson() => {
    "fromBot": fromBot,
    "type": type == MessageType.Audio ? "Audio" : "Text",
    "message": message,
    "path": path,
    "isLocal": isLocal,
    "duration": duration,
  };
}
