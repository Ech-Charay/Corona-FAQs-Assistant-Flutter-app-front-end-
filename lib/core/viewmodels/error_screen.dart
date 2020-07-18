import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white,elevation: 0.0,),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "No Internet Connection",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'Century',
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10,),
            Text(
              "Check your network settings and try again.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Century',
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
                child: Align(
                  alignment: FractionalOffset.center,
                  child: Image.asset('asset/img/error.png'),
                ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                  elevation: 30.0,
                  color: Color.fromRGBO(101, 41, 233, 1),
                  textColor: Colors.white70,
                  child: Text("Retry"),
                  onPressed: (){
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/Chat');
                  },
                ),
                SizedBox(width: 50),
                MaterialButton(
                  elevation: 30.0,
                  color: Color.fromRGBO(101, 41, 233, 1),
                  textColor: Colors.white70,
                  child: Text("Cancel"),
                  onPressed: () async {
                    await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
