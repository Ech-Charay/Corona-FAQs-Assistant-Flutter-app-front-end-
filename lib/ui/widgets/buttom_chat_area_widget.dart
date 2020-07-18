import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomChatArea extends StatefulWidget {
  final TextEditingController chatTextController;
  final Function startRecorder;
  final Function stopRecorder;
  final Function sendMessage;
  const BottomChatArea(
      {this.chatTextController, this.startRecorder, this.stopRecorder, this.sendMessage});

  @override
  _BottomChatAreaState createState() => _BottomChatAreaState();
}

class _BottomChatAreaState extends State<BottomChatArea> {
  bool isRecording;

  @override
  void initState() {
    isRecording = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0.0, 10.0, 5.0, 0.0),
      padding: EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
      decoration: ShapeDecoration(
        color: Color.fromRGBO(101, 41, 233, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 5.0, right: 5.0),
              decoration: ShapeDecoration(
                color: Color.fromRGBO(115, 59, 255, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Row(
                children: <Widget>[
                  _chatTextArea(widget.chatTextController),
                  IconButton(
                    icon: Image.asset("asset/img/send.png"),
                    onPressed: () {
                      widget.sendMessage();
                    },
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            child: isRecording
                ? Image.asset('asset/img/record.png', height: 30,width: 40,)
                : Icon(
              Icons.mic,
              color: Colors.white,
            ),
            onTap: !isRecording
              ? () {
              print("on tap down");
              widget.startRecorder();
              setState(() {
                isRecording = true;
              });
            }
              : () {
              print("on tap up");
              widget.stopRecorder();
              setState(() {
                isRecording = false;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _chatTextArea(TextEditingController controller) {
    return Expanded(
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(style: BorderStyle.none),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(style: BorderStyle.none),
          ),
          filled: true,
          fillColor: Color.fromRGBO(115, 59, 255, 1),
          contentPadding: EdgeInsets.all(10.0),
          hintText: 'Type a message',
          hintStyle: TextStyle(color: Colors.white),
          counterStyle: TextStyle(color: Colors.white),
        ),
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
