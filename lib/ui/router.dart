import 'package:corona_chat_bot/ui/views/chat_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


const String initialRoute = "/Chat";

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => ChatView());
      case '/Chat':
        return MaterialPageRoute(builder: (_) => ChatView());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ),
        );
    }
  }
}