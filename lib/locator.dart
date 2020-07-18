import 'package:corona_chat_bot/core/viewmodels/audio_message_model.dart';
import 'package:get_it/get_it.dart';

import 'core/repositories/chat_repo.dart';
import 'core/services/chat_service.dart';
import 'core/viewmodels/chat_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {

  locator.registerLazySingleton(() => ChatRepo());

  locator.registerLazySingleton(() => ChatService());

  locator.registerFactory(() => ChatModel());
  locator.registerFactory(() => AudioMessageModel());
}