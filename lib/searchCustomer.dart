import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class searchCustomer extends StatefulWidget {
  @override
  _SearchListExampleState createState() => new _SearchListExampleState();
}

class _SearchListExampleState extends State<searchCustomer> {
  bool _isloading=false;
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
    var response = await http.get(Uri.parse("https://pos.sero.app/connector/api/contactapi"), headers: {
      'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjlhNTYwNGYxZDAxMzU2NTRhY2YyYjE4MmEyOGUwMjA4M2QxOGUxY2Y1ZTY0MzM1MzdmNzc3MzFkMTMzZjNmNWQ5MTU3ZTEwOTQ5NDE3ZmQ3In0.eyJhdWQiOiIzIiwianRpIjoiOWE1NjA0ZjFkMDEzNTY1NGFjZjJiMTgyYTI4ZTAyMDgzZDE4ZTFjZjVlNjQzMzUzN2Y3NzczMWQxMzNmM2Y1ZDkxNTdlMTA5NDk0MTdmZDciLCJpYXQiOjE2MjM2NjAxMzksIm5iZiI6MTYyMzY2MDEzOSwiZXhwIjoxNjU1MTk2MTM5LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.WGLAu9KVi-jSt0q9yUyENDoEQnSLF1o0tezej5YozBFXJVQuEvSykvA9T6nnJghujQ2uU-nxUCRftLBhYzGjsu26YoKZBin70k1cqoYDfIWlVZ-fNkJi1vAXYOk9Pzxz7YFBa6hgz1MyUlDOI1LsSSsJh87hGBzIN6Ib_cYmGoo8KHVEfqbDtCNnZdOq68vjhwf6dwYEJUtxanaocuC-_XHkdM7769JiO48Ot93BqZjmRuVwvK9zE_8bilmhktlgD65ahgKOSS2yQlMdpgpsqP1W5Mfy_SBu32BkqTpAc5v2QWRTVhevES-blsfqdoZ59aw0OzrxyC8PvipyuhGQjs6V7eCrKK0jOei9g4RyhKlQueDXxxrWrqsStIsPzkn-kXA5k2NINIFgr2MlLtypTR76xnncWE5rCqm39K5V2_q3aXDQvCHdl3SVBKDqwNCUKq1CxbJlkF8r1R1mxXxN76TBZbcalO7wUX0F-D1j9oWkwXSZBe7L6vQQqvhC2AsQO2LB4QiByuFi1-J4h05vM3Kab0nmRvVeNYekhNP9HtTGWCH_UDuiDAp23VqUhMTrFygUAPEASU0fnw-rMKhrll_O0wMaBE33ZfItsV0o6pHCQhUjsDKwfmgVynOyYu0rX_huVN_PUBSYQVuCiabUMp8Q5Dv7n8Ky7_yI8XypQK4'
    });
    print(response.body.toString());
    var d=json.decode(response.body.toString());
    for(var s in d["data"])
      {
        if(s["type"]=="customer") {
          _list.add(s["name"]);
          _phone.add(s["mobile"]);
        }
      }
    print(response.body.toString());
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
                        onTap: (){
                          print(searchresult[index] +" is selected");
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
                        onTap: (){
                          print(listData.toString() +" is selected");
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
            }
        }
    }
  }}
}