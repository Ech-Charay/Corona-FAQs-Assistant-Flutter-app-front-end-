import 'dart:async';
import 'dart:io' as io;
import 'package:corona_chat_bot/core/enum/messagetype.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';

import 'package:corona_chat_bot/core/models/chatMessageModel.dart';
import 'package:corona_chat_bot/core/services/chat_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:path_provider/path_provider.dart';

import '../enum/viewstate.dart';
import 'base_model.dart';

import '../../locator.dart';

class ChatModel extends BaseModel {
  final ChatService _chatService = locator<ChatService>();

  bool _isLoading;
  List<ChatMessageModel> _chatMessages;
  TextEditingController _chatTextController;
  ScrollController _chatListController;
  FlutterAudioRecorder _recorder;
  LocalFileSystem _localFileSystem;
  bool _hasErrors;

  bool get isLoading => _isLoading;
  List<ChatMessageModel> get chatMessages => _chatMessages;
  TextEditingController get chatTextController => _chatTextController;
  ScrollController get chatListController => _chatListController;
  bool get hasErrors => _hasErrors;

  Future init() async {
    this._isLoading = true;
    setState(ViewState.Busy);
    this._hasErrors = false;
    this._chatTextController = TextEditingController();
    this._chatListController = ScrollController(initialScrollOffset: 0);
    this._chatMessages = List<ChatMessageModel>();
    _localFileSystem = LocalFileSystem();
    await this.getHelloFromTheBot();
    await Future.delayed(Duration(seconds: 3));
    this._isLoading = false;
    setState(ViewState.Idle);
  }

  void chatListScrollToBottom() {
    Timer(Duration(milliseconds: 100), () {
      if (_chatListController.hasClients) {
        _chatListController.animateTo(
            _chatListController.position.maxScrollExtent,
            duration: Duration(milliseconds: 100),
            curve: Curves.decelerate);
      }
    });
  }

  void sendMessageAndGetResponse() async {
    setState(ViewState.Busy);
    String message = _chatTextController.text;
    String messageWithoutSpaces = message.split(' ').join('');
    print('Sending message');
    if (messageWithoutSpaces.isNotEmpty){
      ChatMessageModel chatMessageModel = ChatMessageModel(message: message, type: MessageType.Text, fromBot: false);
      _chatMessages.add(chatMessageModel);
      chatListScrollToBottom();
      _chatTextController.text = '';
      //notify the view about the added message
      setState(ViewState.Idle);
      var botResponse = await _chatService.getResponse(chatMessageModel);
      await addMessagesToModel(botResponse);
    }
    _chatTextController.text = '';
    chatListScrollToBottom();
    // notify the view to adapt with tha latest changes
    setState(ViewState.Idle);
  }

  Future getHelloFromTheBot() async {
    setState(ViewState.Busy);
    var botHello = await _chatService.getBotHello();
    if(botHello.isEmpty)
      this._hasErrors = true;
    await addMessagesToModel(botHello);
    chatListScrollToBottom();
    setState(ViewState.Idle);
  }

  Future addMessagesToModel(List<ChatMessageModel> messages) async {
    for(ChatMessageModel message in messages){
      _chatMessages.add(message);
      chatListScrollToBottom();
      setState(ViewState.Idle);
      await Future.delayed(Duration(seconds: 2));
    }
  }

  Future initRecorder() async {
    try {
      if (await FlutterAudioRecorder.hasPermissions) {
        String customPath = '/flutter_audio_recorder_';
        io.Directory appDocDirectory;
        if (io.Platform.isIOS) {
          appDocDirectory = await getApplicationDocumentsDirectory();
        } else {
          appDocDirectory = await getExternalStorageDirectory();
        }
        // can add extension like ".mp4" ".wav" ".m4a" ".aac"
        customPath = appDocDirectory.path + customPath + DateTime.now().millisecondsSinceEpoch.toString();
        // .wav <---> AudioFormat.WAV
        // .mp4 .m4a .aac <---> AudioFormat.AAC
        // AudioFormat is optional, if given value, will overwrite path extension when there is conflicts.
        _recorder = FlutterAudioRecorder(customPath, audioFormat: AudioFormat.WAV);
        await _recorder.initialized;
        // after initialization
        var current = await _recorder.current(channel: 0);
        print(current);
        // should be "Initialized", if all working fine
      }
    } catch (e) {
      print(e);
    }
  }

  void startRecorder() async {
    try {
      await initRecorder();
      await _recorder.start();
      var recording = await _recorder.current(channel: 0);
      print(recording);
    } catch (e) {
      print(e);
    }
  }
  void stopRecorder() async {
    var result = await _recorder.stop();
    print("Stop recording: ${result.path}");
    print("Stop recording: ${result.duration}");
    if(result.duration.inSeconds > 0){
      File file = _localFileSystem.file(result.path);
      print("File length: ${await file.length()}");
      // add msg to _chatMessages List
      ChatMessageModel chatMessageModel = ChatMessageModel(type: MessageType.Audio, path: result.path, isLocal: true, duration: result.duration.inSeconds, fromBot: false);
      _chatMessages.add(chatMessageModel);
      chatListScrollToBottom();
      //notify the view about the added message
      setState(ViewState.Idle);
      var botResponse = await _chatService.getResponse(chatMessageModel);
      await addMessagesToModel(botResponse);
      chatListScrollToBottom();
    }
    // notify the view to adapt with tha latest changes
    setState(ViewState.Idle);
  }
}