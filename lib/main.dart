import 'package:flutter/material.dart';
import 'package:sero_app/homescreen.dart';

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

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool value = false;
  TextStyle style = TextStyle(fontSize: 20.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFD45F),
      body: Center(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 80,
                  ),
                  Image.asset(
                    'images/x.png',
                    height: 130.0,
                    width: 180.0,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Column(
                    children: <Widget>[
                      Align(
                          alignment: Alignment.centerLeft, child: Text('Email')),
                      SizedBox(
                        height: 10,
                      ),
                      Material(
                        elevation: 10.0,
                        shadowColor: Colors.grey.shade100,
                        child: TextFormField(

                          autofocus: false,
                          decoration: InputDecoration(
                              icon: new Icon(Icons.email, color: Colors.grey),
                              hintText: 'Enter your email',
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 3.0))),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: <Widget>[
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Password')),
                      SizedBox(
                        height: 10,
                      ),
                      Material(
                        elevation: 10.0,
                        shadowColor: Colors.grey.shade100,
                        child: TextFormField(
                          obscureText: true,
                          autofocus: false,
                          decoration: InputDecoration(
                              icon: new Icon(Icons.lock, color: Colors.grey),
                              hintText: 'Password',
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 3.0))),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.white,
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      },
                      child: Text("Login",
                          textAlign: TextAlign.center,
                          style: style.copyWith(
                              color: Colors.black, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Remember me',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ), //Text
                            SizedBox(width: 10), //SizedBox
                            Checkbox(
                              activeColor: Color(0xFF325288),
                              value: this.value,
                              onChanged: (bool value) {
                                setState(() {
                                  this.value = value;
                                });
                              },
                            ),
                          ]),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text('Forgot your password?'),
                  TextButton(
                    onPressed: () {
                      // Respond to button press
                    },
                    child: Text("Sign up",
                    style: TextStyle(
                      color: Colors.black
                    ),),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
