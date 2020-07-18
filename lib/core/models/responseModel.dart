import 'chatMessageModel.dart';

class ResponseModel {
  ResponseModel({
    this.messages,
  });

  List<ChatMessageModel> messages;

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
    messages: (json["messages"] as List)?.map((message) => ChatMessageModel.fromJson(message))?.toList(),
  );

  Map<String, dynamic> toJson() => {
    "messages": messages,
  };
}