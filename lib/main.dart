import 'package:flutter/material.dart';
import 'package:sa_v1_migration/simple_animations/controlled_animation.dart';
import 'package:sa_v1_migration/simple_animations/multi_track_tween.dart';
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
  Animation<double> opacity;
  AnimationController controller;
  checkLoginStatus() async {
    SharedPreferences storage=await SharedPreferences.getInstance();
    print(storage.getString('user_Id'));
    if (storage.getString('user_Id') != null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => HomeScreen()), (
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
      controller = AnimationController(
          duration: Duration(milliseconds: 3000), vsync: this);
      opacity = Tween<double>(begin: 0.2, end: 1.0).animate(controller)
        ..addListener(() {
          setState(() {});
        });
      Future.delayed(Duration(seconds: 3)).then((value) {
        checkLoginStatus();
      });
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xfffdd460),
        child:SafeArea(
        child: Container (
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Column(
                  children: [
                    /*Container(
                        child: Padding(
                          padding: const EdgeInsets.all(36),
                          child: new Image.asset(
                            'images/x.png',height: 250,width: 250,),
                        )),*/
                    FadeAnimation(3,
                        new Image.asset(
                        'images/logo.png',height: 250,width: 250),//0xff000080
                        ),

                    FadeAnimation(3,
                      Text('Sero App',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize:24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff000066)//0xff000080
                        ),),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      ));
  }
}

class FadeAnimation extends StatelessWidget {
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
        opacity: animation["opacity"],
        child: Transform.translate(
            offset: Offset(0, animation["translateY"]),
            child: child
        ),
      ),
    );
  }
}