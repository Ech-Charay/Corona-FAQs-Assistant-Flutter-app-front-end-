import 'package:corona_chat_bot/core/enum/messagetype.dart';
import 'package:corona_chat_bot/core/models/chatMessageModel.dart';
import 'audio_message_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SingleMessageWidget extends StatelessWidget {
  final bool isPreviousFromMe;
  final bool isNextFromMe;
  final ChatMessageModel message;
  SingleMessageWidget(
      {
        Key key,
        this.isPreviousFromMe,
        this.message,
        this.isNextFromMe,
      });

  @override
  Widget build(BuildContext context) {
    bool fromMe = message.fromBot == false;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[

        (isPreviousFromMe == null )
            ? SizedBox(height: 80)
            : Container(),
        Row(
          mainAxisAlignment:
              fromMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: <Widget>[
            Stack(
              alignment: fromMe ? Alignment.bottomRight : Alignment.bottomLeft,
              children: <Widget>[
                // if this msg and the previous one are both from the same person
                // we will not consider padding from top because there will not be an avatar for the user in this case
                (fromMe == isPreviousFromMe)
                    ? Padding(
                        padding: EdgeInsets.fromLTRB(
                            fromMe ? 0 : 58, 0, fromMe ? 20 : 0, 0),
                        child: singleMsg(context, fromMe),
                      )
                    // otherwise we will consider the user's avatar while defining padding for the msg container
                    // if they aren't from the same person and this msg is from me
                    : fromMe
                        ? Container(
                            padding: EdgeInsets.fromLTRB(0, 30, 20, 0),
                            child: singleMsg(context, fromMe),
                          )
                        // if they aren't from the same person and this one isn't from me
                        : Container(
                            padding: EdgeInsets.fromLTRB(58, 30, 0, 0),
                            child: singleMsg(context, fromMe),
                          ),
                // defining user's avatar
                // if it's the first msg in this conversation || this msg and the previous one aren't from the same person
                // we will consider tha avatar // otherwise we will add an empty container
                !fromMe ?
                Container(
                        height: 40,
                        width: 45,
                        margin: EdgeInsets.fromLTRB(10, 0, 5, 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("asset/img/bot_chat.png"),
                          ),
                         // border: Border.all(color: Colors.white, width: 5.0),
                        ),
                      )
                : Container(),
              ],
            ),
          ],
        ),
        // SizedBox for separation purposes between successive messages
        SizedBox(height: (fromMe != isNextFromMe) ? 30.0 : 8.0),
      ],
    );
  }

  Widget singleMsg(BuildContext context, bool fromMe) {
    BoxDecoration decoration;
    Color textColor;
    Map map = initDecoration(fromMe);
    decoration = map["decoration"];
    textColor = map["textColor"];
    return Column(
      // My messages will be aligned in my right and the others in my left
      crossAxisAlignment: fromMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: <Widget>[

        // this container is for the message body
        message.type == MessageType.Audio ?
        Container(
          padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
          width: MediaQuery.of(context).size.width - 100,
          decoration: decoration,
          child: AudioMessage(key: key, message: message,),
        )
        : Container(
          padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
          constraints: BoxConstraints(
              minWidth: 50, maxWidth: MediaQuery.of(context).size.width - 100),
          decoration: decoration,
          child: Text(
            message.message,
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 16.0, color: textColor),
          ),
        ),
      ],
    );
  }

  Map<String, dynamic> initDecoration(bool fromMe) {
    BoxDecoration decoration;
    Color textColor;
    Map map = new Map<String, dynamic>();
    BoxShadow boxShadow = BoxShadow(
        blurRadius: .5,
        spreadRadius: 1.0,
        color: Colors.black.withOpacity(.12));

    if (fromMe) {
      decoration = BoxDecoration(
        color: Color.fromRGBO(101, 41, 233, 1),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(10.0),
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        boxShadow: [boxShadow],
      );
    } else {
      decoration = BoxDecoration(
        color: Colors.white54,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        boxShadow: [boxShadow],
      );
    }
    if(fromMe)
      textColor = Color.fromRGBO(221, 221, 221, 1);
    else
      textColor = Color.fromRGBO(101, 41, 233, 1);
    map.putIfAbsent("decoration", () => decoration);
    map.putIfAbsent("textColor", () => textColor);
    return map;
  }
}
