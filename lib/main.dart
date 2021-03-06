import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ui/router.dart';
import 'locator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


void main() async {
  await DotEnv().load('.env');
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Sign Up Screen ',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
          textTheme: TextTheme(bodyText2: TextStyle( fontFamily: "Times" )),
        ),
        initialRoute: initialRoute,
        onGenerateRoute: Router.generateRoute,
      );
  }


}
