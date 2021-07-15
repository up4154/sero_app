import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sero_app/productdetail.dart';
import 'package:shared_preferences/shared_preferences.dart';
class searchproduct extends StatefulWidget {
  @override
  _SearchListExampleState createState() => new _SearchListExampleState();
}

class _SearchListExampleState extends State<searchproduct> {
  var v;
  List<String> _datalist=[];
  bool _isloading=false;
  Widget appBarTitle = new Text(
    "Search Product",
    style: new TextStyle(color: Colors.black),
  );
  Icon icon = new Icon(
    Icons.search,
    color: Colors.black,
  );
  final globalKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _controller = new TextEditingController();
  List<dynamic> _list=[];
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
    int i=1;
    do{
      SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
      http.Response response = await http.get(
          Uri.parse("https://pos.sero.app/connector/api/variation/?page=$i"), headers: {
        'Authorization':
        sharedPreferences.getString("Authorization")?? ''
      });
      v = (json.decode(response.body));
      print("current+"+v["meta"]["current_page"].toString());
      for(var i in v["data"])
      {
        if(_datalist.contains(i["category"])){
        }
        else {
          if(i["category"]!=null)
          _datalist.add(i["category"]);
          print(_datalist);
        }
      }
      i++;
    }while(v["meta"]["current_page"]!=v["meta"]["last_page"]);
    /*for(var s in v["data"])
    {
        _list.add(s["category"]);
    }*/
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SelectItem(category:_datalist[index],selectedItemsprice:[],selectedItems: [],)));
                        },
                      );
                    },
                  )
                      : new ListView.builder(
                    shrinkWrap: true,
                    itemCount: _datalist.length,
                    itemBuilder: (BuildContext context, int index) {
                      String listData = _datalist[index];
                      return new ListTile(
                        title: new Text(listData.toString()),
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SelectItem(category:_datalist[index],selectedItemsprice:[],selectedItems: [],)));
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
      for (int i = 0; i < _datalist.length; i++) {
        String data = _datalist[i];
        if (data.toLowerCase().contains(searchText.toLowerCase())) {
          searchresult.add(data);
        }
      }
    }}
}