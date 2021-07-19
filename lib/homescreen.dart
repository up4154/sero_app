import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  String _selectedAnimal="";
  int _currentIndex = 0;
  bool _isloading = false;
  late String _name;
  final List<String> _suggestions = [
    'Alligator',
    'Buffalo',
    'Chicken',
    'Dog',
    'Eagle',
    'Frog'
  ];

  final TextEditingController _typeAheadController = TextEditingController();
  String _selectedCity="";
  fetch()

  async {
    setState(() {
      _isloading = true;
    });
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList("selected", []);
    var Response = await http.get(
        Uri.parse("https://pos.sero.app/connector/api/user/loggedin"),
        headers: {
          'Authorization':
          sharedPreferences.getString('Authorization') ?? ''
        });
    var d = json.decode(Response.body.toString());
    setState(() {
      _name = d["data"]["first_name"];
    });
    setState(() {
      _isloading = false;
    });
  } setBottomBarIndex(index) {
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
          padding: const EdgeInsets.only(left: 15,right: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                Image.asset(
                  'images/x.png',
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
                    child: Container(
                      padding: EdgeInsets.all(3),
                      height: MediaQuery.of(context).size.height/22,
                        child:TypeAheadField<Customer>(
                          textFieldConfiguration: TextFieldConfiguration(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                              hintText: "Search Customer"
                            )
                          ),
                                itemBuilder: (BuildContext context,Customer? suggestion) {
                                  final content=suggestion!;
                                  return ListTile(
                                    title: Text(content._name+"  ("+content._phone+")"),
                                  );
                                },
                                onSuggestionSelected: (Customer? suggestion) async {
                                  Fluttertoast.showToast(
                                      msg:suggestion!._name+" is selected",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      textColor: Colors.green,
                                      timeInSecForIosWeb: 10);
                                  SharedPreferences prefs= await SharedPreferences.getInstance();
                                  prefs.setString("customer_name",suggestion._name);
                                },
                                suggestionsCallback: CustomerApi.getUserSuggestion,
                              )
                        
                        ),
                )),
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
class Customer
{
  final String _name;
  final String _phone;
  final String id;
  Customer.fromJson(Map<String,dynamic> json):
        this._name=json["first_name"]??json["name"],
        this._phone=json["mobile"],
        this.id=json["id"].toString();

}
class CustomerApi {
  static Future<List<Customer>> getUserSuggestion(String query)
  async {
    int i = 1;
    var pages;
    List<Customer>name = [];

    late Customer cus;
    do {
      var response = await http.get(
          Uri.parse("https://pos.sero.app/connector/api/contactapi/?page=$i"),
          headers: {
            'Authorization': "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjMwYjE2MGVhNGUzMzA4ZTNiMjhhZGNlYWEwNjllZTA2NjI5Y2M4ZjMxMWFjZjUwMDFjZmZkMTE1ZDZlNTliZGI5NmJlZmQ3ZGYzYjRhNWNhIn0.eyJhdWQiOiIzIiwianRpIjoiMzBiMTYwZWE0ZTMzMDhlM2IyOGFkY2VhYTA2OWVlMDY2MjljYzhmMzExYWNmNTAwMWNmZmQxMTVkNmU1OWJkYjk2YmVmZDdkZjNiNGE1Y2EiLCJpYXQiOjE2MjU4OTY4MDcsIm5iZiI6MTYyNTg5NjgwNywiZXhwIjoxNjU3NDMyODA3LCJzdWIiOiI4Iiwic2NvcGVzIjpbXX0.OJ9XTCy8i5-f17ZPWNpqdT6QMsDgSZUsSY9KFEb-2O6HehbHt1lteJGlLfxJ2IkXF7e9ZZmydHzb587kqhBc_GP4hxj6PdVpoX_GE05H0MGOUHfH59YgSIQaU1cGORBIK2B4Y1j4wyAmo0O1i5WAMQndkKxA03UFGdipiobet64hAvCIEu5CipJM7XPWogo2gLUoWob9STnwYQuOgeTLKfMsMG4bOeaoVISy3ypALDJxZHi85Q9DZgO_zbBp9MMOvhYm9S1vPzoKCaGSx2zNtmOtCmHtUAxCZbu0TR2VDN7RpLdMKgPF8eLJglUhCur3BQnXZfYWlVWdG-T3PCKMvJvoE6rZcVXy2mVJUk3fWgldcOAhPRmQtUS563BR0hWQDJOL3RsRAjeesMhRouCtfmQBcW83bRindIiykYV1HrjdJBQNb3yuFFJqs9u7kgVFgZmwzsbd512t9Vfe1Cq_DhXbJM2GhIoFg72fKbGImu7UnYONUGB3taMmQn4qCXoMFnDl7glDLU9ib5pbd0matbhgkydHqThk5RZOPWje9W93j9RvwqwYL1OkcV9VXWcxYk0wwKRMqNtx74GLOUtIh8XJDK3LtDpRwLKer4dDPxcQHNgwkEH7iJt40bd9j27Mcyech-BZDCZHRSZbwhT7GnNeu2IluqVq3V0hCW3VsB8" ??
                ''
          });
      final List d = json.decode(response.body)["data"];
      pages=json.decode(response.body);
      print(d);
      name.addAll(d.map((e) => Customer.fromJson(e)).where((element) {
        final name = element._name.toLowerCase();
        final _name = query.toLowerCase();
        final phone = element._phone;
        final _phone = query;
        if (name.contains(_name))
          return name.contains(_name);
        else if(phone.contains(_phone))
          return phone.contains(_phone);
        else
          return false;
      }
      ).toList());
      i++;
    }while(i<=pages["meta"]["last_page"]);
    return name;
  }
}