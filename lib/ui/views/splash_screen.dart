import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(101, 41, 233, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(101, 41, 233, 1),
        elevation: 0,
        leading: Row(
          children: <Widget>[
            SizedBox(width: 8.0),
            Ink(
              decoration: ShapeDecoration(
                color: Color.fromRGBO(89, 30, 216, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onPressed: () async {
                  await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
              ),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(
            height: 30.0,
          ),
          Text(
            "CoronaVirus",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              color: Colors.white70,
              fontFamily: 'Century',
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            "FAQs assistant",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              color: Colors.white70,
              fontFamily: 'Century',
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Image.asset("asset/img/bott.png", height: 170, width: 170,),
          SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Image(image: new AssetImage("asset/img/loading.gif")),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
