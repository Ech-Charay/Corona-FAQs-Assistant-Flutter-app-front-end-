import 'package:corona_chat_bot/core/models/chatMessageModel.dart';
import 'package:corona_chat_bot/core/repositories/chat_repo.dart';

import '../../locator.dart';

class ChatService {
  ChatRepo _api = locator<ChatRepo>();

  Future<List<ChatMessageModel>> getResponse(ChatMessageModel message) async {

    var fetchedResponse = await _api.fetchResponse(message);
    var hasData = fetchedResponse != null;
    var messages;
    if (hasData) {
      messages = fetchedResponse.messages;
      print('${this.runtimeType.toString()}:---> Response fetched successfully');
    } else {
      messages = List<ChatMessageModel>();
      print("${this.runtimeType.toString()}:---> Failed to load Response from the bot");
    }
    return messages;
  }

  Future<List<ChatMessageModel>> getBotHello() async {
    var botHello = await _api.fetchIndex();
    var hasData = botHello != null;
    var messages;
    if (hasData) {
      messages = botHello.messages;
      print('${this.runtimeType.toString()}:---> Bot Hello fetched successfully');
    } else {
      messages = List<ChatMessageModel>();
      print("${this.runtimeType.toString()}:---> Failed to load Hello messages from the bot");
    }
    return messages;
  }
}
