import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sero_app/selecttable.dart';
import 'package:shared_preferences/shared_preferences.dart';
class searchCustomer extends StatefulWidget {
  @override
  _SearchListExampleState createState() => new _SearchListExampleState();
}

class _SearchListExampleState extends State<searchCustomer> {
  bool _isloading=false;
  var d;
  Widget appBarTitle = new Text(
    "Search Customer",
    style: new TextStyle(color: Colors.black),
  );
  Icon icon = new Icon(
    Icons.search,
    color: Colors.black,
  );
  final globalKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _controller = new TextEditingController();
  List<dynamic> _list=[];
  List<dynamic> _phone=[];
  List searchname = [];
  bool _isSearching=false;
  String _searchText = "";
  List searchresult = [];

  _SearchListExampleState() {
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _controller.text;
        });
      }
    });
  }

  @override
  void initState() {
    setState(() {
      _isloading=true;
    });
    super.initState();
    _isSearching = false;
    values();
  }

  Future<void> values() async {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    int i=1;
    do{
    var response = await http.get(Uri.parse("https://pos.sero.app/connector/api/contactapi/?page=$i"), headers: {
      'Authorization':sharedPreferences.getString("Authorization") ?? ''
    });
    print(response.body.toString());
     d=json.decode(response.body.toString());
    for(var s in d["data"])
      {
        if(s["type"]=="customer") {
          _list.add(s["first_name"]??s["name"]);
          _phone.add(s["mobile"]);
        }
        print("Last"+d["meta"]["last_page"].toString());
        print("i="+i.toString());
      }
    i++;
      }while(i<=d["meta"]["last_page"]);
    setState(() {
      _isloading=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: globalKey,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: buildAppBar(context)),
      body:_isloading?Center(child:CircularProgressIndicator(color: Color(0xff000066),)): new Container(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Flexible(
                  child: searchresult.length != 0 || _controller.text.isNotEmpty
                      ? new ListView.builder(
                    shrinkWrap: true,
                    itemCount: searchresult.length,
                    itemBuilder: (BuildContext context, int index) {
                      String listData = searchresult[index];
                      return new ListTile(
                        title: new Text(listData.toString()),
                        onTap: () async {
                          print(searchresult[index] +" is selected");
                          if(searchresult[index].toString().contains("(")){print("Yes");
                          String v=searchresult[index].toString().substring(0,searchresult[index].toString().indexOf("("));
                          print(v);
                          SharedPreferences prefs= await SharedPreferences.getInstance();
                          prefs.setString("customer_name", v);
                          }
                          else {
                            SharedPreferences prefs = await SharedPreferences
                                .getInstance();
                            prefs.setString("customer_name",
                                searchresult[index]);
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SelectTable()),
                          );
                        },
                      );
                    },
                  )
                      : new ListView.builder(
                    shrinkWrap: true,
                    itemCount: _list.length,
                    itemBuilder: (BuildContext context, int index) {
                      String listData = _list[index];
                      return new ListTile(
                        title: new Text(listData.toString()),
                        onTap: () async {
                          print(listData.toString() +" is selected");
                          SharedPreferences prefs= await SharedPreferences.getInstance();
                          prefs.setString("customer_name", listData);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SelectTable()),
                          );
                        },
                      );
                    },
                  ))
            ],
          ),
        ));
  }

  Widget buildAppBar(BuildContext context) {
    return new AppBar(centerTitle: true, title: appBarTitle, actions: <Widget>[
      new IconButton(
        icon: icon,
        onPressed: () {
          setState(() {
            if (this.icon.icon == Icons.search) {
              this.icon = new Icon(
                Icons.close,
                color: Colors.black,
              );
              this.appBarTitle = new TextField(
                controller: _controller,
                style: new TextStyle(
                  color: Colors.black,
                ),
                decoration: new InputDecoration(
                    prefixIcon: new Icon(Icons.search, color: Colors.black),
                    hintText: "Search...",
                    hintStyle: new TextStyle(color: Colors.black)),
                onChanged: searchOperation,
              );
              _handleSearchStart();
            } else {
              _handleSearchEnd();
            }
          });
        },
      ),
    ]);
  }

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.icon = new Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = new Text(
        "Search Sample",
        style: new TextStyle(color: Colors.white),
      );
      _isSearching = false;
      _controller.clear();
    });
  }

  void searchOperation(String searchText) {
    searchresult.clear();
    if (_isSearching != null) {
      for (int i = 0; i < _list.length; i++) {
        String data = _list[i];
        if (data.toLowerCase().contains(searchText.toLowerCase())) {
          searchresult.add(data);
        }
      }
      if(searchresult.isEmpty)
        {
          for (int i = 0; i < _phone.length; i++) {
            String data = _phone[i];
            if (data.toLowerCase().contains(searchText.toLowerCase())) {
              searchresult.add(_list[i]+"("+data+")");
              searchname.add(_list[i]);
            }
        }
    }
  }}
}