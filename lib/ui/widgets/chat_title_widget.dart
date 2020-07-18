import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatTitle extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      backgroundColor: Colors.white,
      leading: Wrap(
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(width: 8.0),
              Ink(
                decoration: ShapeDecoration(
                  color: Color.fromRGBO(230, 230, 230, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Color.fromRGBO(101, 41, 233, 1),),
                  onPressed: () async {
                    Navigator.pop(context);
                    await Navigator.pushNamed(context, '/Chat');
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      pinned: true,
      floating: false,
      expandedHeight: 60.0,
      flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Text(
            "Covid-Bot",
            style: TextStyle(fontSize: 20, color: Color.fromRGBO(50, 22, 195, 1), fontFamily: 'Century'),
          )),
    );
  }
}
