import 'package:flutter/material.dart';
import 'package:sero_app/homescreen.dart';
import 'package:sero_app/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return  _HomePage();
  }
}
class _HomePage extends State<MyHomePage> with SingleTickerProviderStateMixin
{
  checkLoginStatus() async {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    print(sharedPreferences.getString('user_id'));
    if (sharedPreferences.getString('user_id') != null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => HomeScreen(title: "Home Screen")), (
          Route<dynamic> route) => false);
    } else {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
          builder: (BuildContext context) => login()), (
          Route<dynamic> route) => false);
    }
  }
    @override
    void initState() {
      super.initState();
      Future.delayed(Duration(seconds: 3)).then((value) {
        checkLoginStatus();
      });
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xffffd45f),
        child:SafeArea(
        child: Container (
         child: Text("Welcome"),
        ),
      ),
      ));
  }
}

/*class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("opacity").add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
      Track("translateY").add(
          Duration(milliseconds: 500), Tween(begin: -30.0, end: 0.0),
          curve: Curves.easeOut)
    ]);

    return ControlledAnimation(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: animation!["opacity"],
        child: Transform.translate(
            offset: Offset(0, animation["translateY"]),
            child: child
        ),
      ),
    );
  }
}*/