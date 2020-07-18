import 'dart:async';

import 'package:audioplayer/audioplayer.dart';
import 'package:corona_chat_bot/core/enum/playerstate.dart';
import 'package:corona_chat_bot/core/enum/viewstate.dart';
import 'package:corona_chat_bot/core/models/chatMessageModel.dart';
import 'package:corona_chat_bot/core/viewmodels/base_model.dart';

typedef void OnError(Exception exception);

class AudioMessageModel extends BaseModel {

  Duration _duration;
  Duration _position;
  AudioPlayer _audioPlayer;
  PlayerState _playerState;

  get isPlaying => _playerState == PlayerState.playing;
  get isPaused => _playerState == PlayerState.paused;
  get audioPlayer => _audioPlayer;
  get position => _position;
  get duration => _duration;

  StreamSubscription _positionSubscription;
  StreamSubscription _audioPlayerStateSubscription;

  void init(ChatMessageModel message) {
    setState(ViewState.Busy);
    this._audioPlayer = AudioPlayer();
    this._playerState = PlayerState.stopped;
    this._duration = Duration(seconds: message.duration);
    this._position = Duration(seconds: 0);
    this._positionSubscription = this._audioPlayer.onAudioPositionChanged
        .listen((p) {
          if(p > Duration(milliseconds: 1) && p < this._duration) {
            this._position = p;
            setState(ViewState.Idle);
          }else {
            this._position = Duration(milliseconds: 1);
            this._playerState = PlayerState.stopped;
            setState(ViewState.Idle);
          }
        });
    setState(ViewState.Idle);
  }

  Future pause() async {
    setState(ViewState.Busy);
    await this._audioPlayer.pause();
    this._playerState = PlayerState.paused;
    setState(ViewState.Idle);
  }

  Future stop() async {
    setState(ViewState.Busy);
    await this._audioPlayer.stop();
    this._playerState = PlayerState.stopped;
    this._position = Duration();
    setState(ViewState.Idle);
  }

  void play(ChatMessageModel message) async {
    setState(ViewState.Busy);
    await this._audioPlayer.play(message.path, isLocal: message.isLocal);
    this._playerState = PlayerState.playing;
    setState(ViewState.Idle);
  }

  @override
  void dispose() {
    this._positionSubscription.cancel();
    this._audioPlayerStateSubscription.cancel();
    this._audioPlayer.stop();
    super.dispose();
  }
}