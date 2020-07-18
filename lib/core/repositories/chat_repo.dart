import 'dart:convert';
import 'dart:io';

import 'package:corona_chat_bot/core/enum/messagetype.dart';
import 'package:corona_chat_bot/core/models/chatMessageModel.dart';
import 'package:corona_chat_bot/core/models/responseModel.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;
import 'package:path/path.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatRepo{
  final endpoint = DotEnv().env['API_URL'];

  // Method to fetch response from the bot
  Future<ResponseModel> fetchResponse(ChatMessageModel message) async {
    print("sending request to fetch response from the bot ********************************");
    var response;
    try {
      /// CREATING INSTANCE
      var dioRequest = dio.Dio();
      dioRequest.options.baseUrl = "$endpoint/dialog";

      /// ADDING EXTRA INFO
      var formData = new dio.FormData.fromMap(message.toJson());

      /// ADD RECORD TO UPLOAD
      if(message.type == MessageType.Audio) {
        var file = await dio.MultipartFile.fromFile(
          message.path,
          filename: basename(message.path),
        );

        formData.files.add(MapEntry('record', file));
      }

      /// SEND TO SERVER
      response = await dioRequest.post(
        "$endpoint/dialog",
        data: formData,
      );
    } catch (err) {
      print('ERROR  $err');
    }
    var botResponse;
    if(response != null && response.statusCode == 200)
      botResponse = ResponseModel.fromJson(json.decode(response.toString()));
    return botResponse;
  }

  // Method to fetch index route (Hello messages)
  Future<ResponseModel> fetchIndex() async {
    print("sending request to fetch index route from the botServer ********************************");
    String url = "$endpoint";
    try{
      var response = await http.get(url);
      var botResponse;
      if(response.statusCode == 200)
        botResponse = ResponseModel.fromJson(json.decode(response.body));
      return botResponse;
    } on SocketException {
      print("!!!!!!!!!!!!!!!!!!!!not connected !!!!!!!!!!!!!!!!");
      return null;
    }
  }
}