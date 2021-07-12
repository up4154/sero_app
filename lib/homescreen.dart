import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sero_app/personaldetails.dart';
import 'package:sero_app/selecttable.dart';
import 'package:sero_app/forget_password.dart';
import 'package:sero_app/searchCustomer.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key,  required this.title}) : super(key: key);

  final String title;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextStyle style = TextStyle(fontSize: 20.0);
  bool value = false;
  bool value1 = false;
  int _currentIndex = 0;
  bool _isloading=false;
  late String _name;
  fetch()
  async {
    setState(() {
      _isloading=true;
    });
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    var Response=await http.get("https://pos.sero.app/connector/api/user/loggedin",headers: {
      'Authorization':
          sharedPreferences.getString("Authorization")
    });
    var d=json.decode(Response.body.toString());
    setState(() {
      _name=d["data"]["first_name"];
    });
    setState(() {
      _isloading=false;
    });
  }
  setBottomBarIndex(index){
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    fetch();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              // button 1
              IconButton(
                icon: Icon(Icons.home_sharp,
                  color: _currentIndex == 0 ? Color(0xFFFFD45F) : Colors.grey[800],
                ),
                onPressed: (){
                  setBottomBarIndex(0);
                },
                splashColor: Colors.white,
              ),

              // button 2
              IconButton(
                  icon: Icon(Icons.border_all_rounded,
                    color: _currentIndex == 1 ? Color(0xFFFFD45F) : Colors.grey[800],
                  ),
                  onPressed: (){
                    setBottomBarIndex(1);
                  }),

              // button 3
              IconButton(
                  icon: Icon(Icons.shopping_cart,
                    color: _currentIndex == 2 ? Color(0xFFFFD45F) : Colors.grey[800],
                  ),
                  onPressed: (){
                    setBottomBarIndex(2);
                  }),

              // button 4
              IconButton(
                  icon: Icon(Icons.open_in_browser_sharp,
                    color: _currentIndex == 3 ? Color(0xFFFFD45F) : Colors.grey[800],
                  ),
                  onPressed: (){
                    setBottomBarIndex(3);
                  }),
            ],
          ),
        ),
      ),
      body:  _isloading?Center(child:CircularProgressIndicator(color: Color(0xff000066),)):Padding(
          padding: const EdgeInsets.all(36.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  height: 80,
                ),
                Image.asset(
                  'images/logo.png',
                  height: 130.0,
                  width: 180.0,
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text(
                 _name,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Material(
                  elevation: 10.0,
                  borderRadius: BorderRadius.circular(30.0),
                  color: const Color(0xFFFFD45F),
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(child:Icon(Icons.search),
                        onTap: (){

                        },
                        ),
                        GestureDetector(child:Text(
                          "Search Customer",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                          onTap:(){Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => searchCustomer()));
                          }
                        ),
                        GestureDetector(child:Icon(Icons.person_add,),
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PersonalDetails()),
                          );
                        },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Text('Select mode'),
                SizedBox(
                  height: 30,
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
                          MaterialPageRoute(
                          builder: (context) => SelectTable()));
                    },
                    child: Text("Dine in",
                        textAlign: TextAlign.center,
                        style: style.copyWith(color: Colors.black)),
                  ),
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
                    child: Text("Take Away",
                        textAlign: TextAlign.center,
                        style: style.copyWith(color: Colors.black)),
                  ),
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
                    child: Text("Home Delivery",
                        textAlign: TextAlign.center,
                        style: style.copyWith(color: Colors.black)),
                  ),
                ),
              ],
            ),
          ),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
