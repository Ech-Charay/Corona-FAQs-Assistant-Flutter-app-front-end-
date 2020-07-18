import 'package:corona_chat_bot/core/viewmodels/chat_model.dart';
import 'package:corona_chat_bot/core/viewmodels/error_screen.dart';
import 'package:corona_chat_bot/ui/views/splash_screen.dart';
import 'package:corona_chat_bot/ui/widgets/buttom_chat_area_widget.dart';
import 'package:corona_chat_bot/ui/widgets/chat_title_widget.dart';
import 'package:corona_chat_bot/ui/widgets/single_message_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'base_view.dart';

class ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<ChatModel>(
        onModelReady: (model) => model.init(),
        builder: (context, model, child) {
          if(model.isLoading){
            SystemChrome.setEnabledSystemUIOverlays([]);
            return SplashScreen();
          }else if(model.hasErrors){
            SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
            return ErrorScreen();
          } else {
            SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
            return Scaffold(
              extendBodyBehindAppBar: true,
              backgroundColor: Colors.white,
              body: CustomScrollView(
                controller: model.chatListController,
                slivers: <Widget>[
                  ChatTitle(),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        return SingleMessageWidget(
                          key: UniqueKey(),
                          isPreviousFromMe: index - 1 > -1
                              ? model.chatMessages[index - 1].fromBot ==
                              false
                              : null,
                          isNextFromMe:
                          index + 1 < model.chatMessages.length
                              ? model.chatMessages[index + 1].fromBot ==
                              false
                              : null,
                          message: model.chatMessages[index],
                        );
                      },
                      childCount: model.chatMessages.length,
                    ),
                  ),
                  SliverFillRemaining(
                    fillOverscroll: false,
                    hasScrollBody: false,
                    child: SizedBox(
                      height: 100,
                    ),
                  )
                ],
              ),
              bottomSheet: Container(
                margin: EdgeInsets.fromLTRB(5, 0, 0, 10),
                child: BottomChatArea(
                  chatTextController: model.chatTextController,
                  startRecorder: model.startRecorder,
                  stopRecorder: model.stopRecorder,
                  sendMessage: model.sendMessageAndGetResponse,
                ),
              ),
            );
          }
        });
  }
}
