import 'package:corona_chat_bot/core/models/chatMessageModel.dart';
import 'package:corona_chat_bot/core/viewmodels/audio_message_model.dart';
import 'package:corona_chat_bot/ui/views/base_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AudioMessage extends StatelessWidget {
  final ChatMessageModel message;
  const AudioMessage({Key key, this.message});

  @override
  Widget build(BuildContext context) {
    return BaseView<AudioMessageModel>(
      onModelReady: (model) => model.init(message),
      builder: (context, model, child) => Row(
        children: <Widget>[
          model.isPlaying
          ? IconButton(
            icon: Icon(
              Icons.pause_circle_filled,
              color: Colors.white,
            ),
            onPressed: () => model.pause(),
          )
          : IconButton(
            icon: Icon(
              Icons.play_circle_filled,
              color: Colors.white,
            ),
            onPressed: () => model.play(message),
          ),
          Expanded(
            child: Slider(
              key: key,
              value: model.position.inMilliseconds.toDouble(),
              onChanged: (double value) {
                return model.audioPlayer.seek((value / 1000).roundToDouble());
              },
              min: 0.0,
              max: model.duration.inMilliseconds.toDouble(),
              inactiveColor: Colors.white,
              activeColor: Colors.black38,
            ),
          ),
          Text(
            formatDuration(model.duration),
            textAlign: TextAlign.end,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  String formatDuration(Duration n){
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }
    String twoDigitMinutes = twoDigits(n.inMinutes.remainder(Duration.minutesPerHour));
    String twoDigitSeconds = twoDigits(n.inSeconds.remainder(Duration.secondsPerMinute));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
