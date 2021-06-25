import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sero_app/personaldetails.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  TextStyle style = TextStyle(fontSize: 20.0);
  bool value = false;
  bool value1 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // SizedBox(
              //   height: 20,
              // ),
              Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(30.0),
                color: const Color(0xFFfad586),
                child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  onPressed: () {},
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.search),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Search Product",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        width: 130,
                      ),
                      Icon(Icons.qr_code_scanner),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.white,
                child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    onPressed: () {},
                    child: new Row(
                      children: [
                        Icon(
                          Icons.local_pizza,
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Text("Pizza",
                            textAlign: TextAlign.center,
                            style: style.copyWith(color: Colors.black)),
                        SizedBox(
                          width: 155,
                        ),
                        Icon(
                          Icons.arrow_forward,
                        ),
                      ],
                    )),
              ),

              SizedBox(
                height: 20,
              ),
              Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.white,
                child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    onPressed: () {},
                    child: new Row(
                      children: [
                        Icon(Icons.lunch_dining),
                        SizedBox(
                          width: 25,
                        ),
                        Text("Burger",
                            textAlign: TextAlign.center,
                            style: style.copyWith(color: Colors.black)),
                        SizedBox(
                          width: 140,
                        ),
                        Icon(
                          Icons.arrow_forward,
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.white,
                child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    onPressed: () {},
                    child: new Row(
                      children: [
                        Icon(Icons.lunch_dining),
                        SizedBox(
                          width: 25,
                        ),
                        Text("Burger",
                            textAlign: TextAlign.center,
                            style: style.copyWith(color: Colors.black)),
                        SizedBox(
                          width: 140,
                        ),
                        Icon(
                          Icons.arrow_forward,
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.white,
                child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    onPressed: () {},
                    child: new Row(
                      children: [
                        Icon(Icons.lunch_dining),
                        SizedBox(
                          width: 25,
                        ),
                        Text("Burger",
                            textAlign: TextAlign.center,
                            style: style.copyWith(color: Colors.black)),
                        SizedBox(
                          width: 140,
                        ),
                        Icon(
                          Icons.arrow_forward,
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.white,
                child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    onPressed: () {},
                    child: new Row(
                      children: [
                        Icon(Icons.lunch_dining),
                        SizedBox(
                          width: 25,
                        ),
                        Text("Burger",
                            textAlign: TextAlign.center,
                            style: style.copyWith(color: Colors.black)),
                        SizedBox(
                          width: 140,
                        ),
                        Icon(
                          Icons.arrow_forward,
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
