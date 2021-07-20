import 'dart:convert';
import 'package:sero_app/addons_and_modifiers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sero_app/utsav/cart_screen.dart';
//import 'package:barcode_scan/barcode_scan.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectItem extends StatefulWidget {
  String category;
  List<String> selectedItems = [];
  List<String> selectedItemsprice = [];
  SelectItem({Key ? key,required this.category,required this.selectedItemsprice,required this.selectedItems});

  @override
  State<SelectItem> createState() => _SelectItemState();
}

class _SelectItemState extends State<SelectItem> {
    var v;
    //List<String> selectedReportList = [];
    bool _isSearching=false;
    List<String> searchresult = [];
    List<String> searchresultImages = [];
    List<String> searchresultprice=[];
    List<String> images = [];
    List<String> price=[];
    List<String> _selectedItems = [];
    List<String> _selectedItemsprice = [];
    TextEditingController _controller=new TextEditingController();
    List<String> name = [];
    List<String> id = [];
    bool _isloading = false;
    var _searchText;
    Future<void> get() async {
      setState(() {
        _isloading = true;
      });
      _SelectItemState() {
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
      int i=1;
      SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
      do{
      http.Response response = await http.get(
          Uri.parse("https://pos.sero.app/connector/api/variation/?page=$i"), headers: {
        'Authorization':
        sharedPreferences.getString("Authorization") ?? ''

      });
       v = (json.decode(response.body));
      for (var i in v["data"]) {
        if (i["category"] == widget.category) {
          price.add(i["sell_price_inc_tax"]);
          name.add(i["product_name"]);
          images.add(i["product_image_url"]);
          id.add(i["product_id"].toString());
        }
      }
      i++;
      }while(v["meta"]["current_page"]!=v["meta"]["last_page"]);
      setState(() {
        _isloading = false;
      });
    }
    @override
    void initState() {
      get();
      super.initState();
    }
    void _handleSearchStart() {
      setState(() {
        _isSearching = true;
      });
    }
    void searchOperation(String searchText) {
      searchresult.clear();
      if (_isSearching != null) {
        for (int i = 0; i < name.length; i++) {
          String data = name[i];
          var img=images[i];
          if (data.toLowerCase().contains(searchText.toLowerCase())) {
            searchresult.add(data);
            searchresultImages.add(img);
            searchresultprice.add(price[i]);
          }
        }
      }}
    int _currentIndex = 0;
    setBottomBarIndex(index) {
      setState(() {
        _currentIndex = index;
      });}
    @override
    Widget build(BuildContext context) {
      return Scaffold(
          bottomNavigationBar:BottomAppBar(
            color: Colors.white,
            shape: CircularNotchedRectangle(),
            child: Container(
              height: 70,
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
          appBar: AppBar(
            flexibleSpace:  Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft:Radius.circular(30),bottomRight:Radius.circular(30),),
                      color :const Color(0xffffd45f),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: const Offset(
                            1.0,
                            1.0,
                          ), //Offset
                          blurRadius: 0.0,
                          spreadRadius: 2.0,
                        ), //BoxShadow
                        BoxShadow(
                          color: Colors.white,
                          offset: const Offset(0.0, 0.0),
                          blurRadius: 0.0,
                          spreadRadius: 0.0,
                        ),],
                    ),
                    height:150,
                    child:Padding(
                      padding: const EdgeInsets.only(top:30),
                      child: Column(
                        children:[Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                alignment: Alignment.topLeft,
                                icon: const Icon(Icons.menu),
                                onPressed: () {
                                },
                              ),
                              Text(widget.category,
                                style: TextStyle(fontSize: 23,fontWeight: FontWeight.w500),),
                              CircleAvatar(
                                  backgroundImage: NetworkImage('https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500')
                              ),
                            ]),
                          /*Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [*/
                          Container(
                            width: MediaQuery.of(context).size.width/1.3,
                            child:
                            Material(
                              elevation: 5.0,
                              borderRadius: BorderRadius.circular(30.0),
                              color: Colors.white,
                              child: MaterialButton(
                                minWidth:MediaQuery.of(context).size.width/3,
                                height: MediaQuery.of(context).size.height/20,
                                padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                onPressed: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      height: MediaQuery.of(context).size.height/20,
                                      width: MediaQuery.of(context).size.width/1.6,
                                      child:TextField(
                                          controller: _controller,
                                          cursorColor: Colors.black,
                                          decoration: InputDecoration(
                                              fillColor: Colors.black,
                                              focusColor: Colors.black,
                                              hoverColor: Colors.black,
                                              hintText: "Search..",
                                              focusedBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.black)
                                              ),
                                              prefixIcon: Icon(
                                                Icons.search,color: Colors.black,
                                              ),


                                          ),
                                          onChanged: (value){
                                            _handleSearchStart();
                                            searchOperation(value);
                                          }
                                      ),),


                                  ],
                                ),
                              ),
                            ),
                            //],
                            //)
                          )],
                      ),
                    ),
                  ),
                ]
            ),
            toolbarHeight: 130,
            backgroundColor: Colors.white,
          ),
            /*'Select your food item'-*/

          body: _isloading?Center(child:CircularProgressIndicator(color: Color(0xff000066),)):searchresult.length != 0 || _controller.text.isNotEmpty?
          GridView.builder(
              primary: false,
              padding: const EdgeInsets.all(10),
              itemCount: searchresult.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 22.0,
                mainAxisSpacing: 25.0,

              ),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 4,
                  //width: 550,
                  //width: 550,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10)
                  ),
                  padding: const EdgeInsets.all(3),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height/14,
                        width: MediaQuery.of(context).size.width,
                        child: CircleAvatar(
                            backgroundImage: NetworkImage(searchresultImages[index])
                        ),),
                      Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height / 25,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        child: Text(
                          searchresult[index],
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 10),
                        ),),
                    ],
                  ),
                ),
                    onTap: () async {
                      SharedPreferences sharedPreferences = await SharedPreferences
                          .getInstance();
                      print(id[index]);
                      http.Response response = await http.get(
                          Uri.parse(
                              "https://pos.sero.app/connector/api/product/${id[index]}")
                          , headers: {
                        'Authorization':
                        sharedPreferences.getString("Authorization") ?? ''
                      });
                      var v = (json.decode(response.body));
                      //print(v["data"][0]["modifiers"]);
                      List<dynamic> check = v["data"][0]["modifiers"];
                      List<String> modifiers = [];
                      if (check.isNotEmpty) {
                        for (var _mod in v["data"][0]["modifiers"][0]) {
                          print(_mod["name"]);
                          modifiers.add(_mod["name"]);
                        }
                      }
                      if (modifiers.isEmpty) {
                        var list = sharedPreferences.getStringList("selected");
                        var listofprice=sharedPreferences.getStringList("selectedprice");
                        //_selectedItems.add(name[index]);
                        setState(() {
                          var _price=searchresultprice[index];
                          var product = searchresult[index];
                          list!.add(product);
                          listofprice!.add(_price);
                          sharedPreferences.setStringList("selected", []);
                          sharedPreferences.setStringList("selected", list);
                          sharedPreferences.setStringList("selectedprice", []);
                          sharedPreferences.setStringList("selectedprice", listofprice);
                        });
                        print(sharedPreferences.getStringList("selected"));
                        gotocart();
                      }
                      else {
                        showDialog(context: context, builder: (context) {
                          return add(modifiers: modifiers);
                        });
                      }
                    });
              }):GridView.builder(
              primary: false,
              padding: const EdgeInsets.all(10),
              itemCount: images.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 25.0,
                mainAxisSpacing: 25.0,

              ),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 4,
                  //width: 550,
                  //width: 550,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10)
                  ),
                  padding: const EdgeInsets.all(3),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 6,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height/14,
                        width: MediaQuery.of(context).size.width,
                        child: CircleAvatar(
                            backgroundImage: NetworkImage(images[index])
                        ),),
                      Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height / 25,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        child: Text(
                          name[index],
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 10),
                        ),),
                    ],
                  ),
                ),
                  onTap: () async {
                    SharedPreferences sharedPreferences = await SharedPreferences
                        .getInstance();
                    print(id[index]);
                    http.Response response = await http.get(
                        Uri.parse(
                            "https://pos.sero.app/connector/api/product/${id[index]}")
                        , headers: {
                      'Authorization':
                      sharedPreferences.getString("Authorization") ?? ''
                    });
                    var v = (json.decode(response.body));
                    //print(v["data"][0]["modifiers"]);
                    List<dynamic> check = v["data"][0]["modifiers"];
                    List<String> modifiers = [];
                    if (check.isNotEmpty) {
                      for (var _mod in v["data"][0]["modifiers"][0]) {
                      print(_mod["name"]);
                      modifiers.add(_mod["name"]);
                      }
                      }
                      if (modifiers.isEmpty) {
                        var list = sharedPreferences.getStringList("selected");
                        var listofprice=sharedPreferences.getStringList("selectedprice");
                        var product = name[index];
                        var _price=price[index];
                        list!.add(product);
                        listofprice!.add(_price);
                        sharedPreferences.setStringList("selected", []);
                        sharedPreferences.setStringList("selected", list);
                        sharedPreferences.setStringList("selectedprice", []);
                        sharedPreferences.setStringList("selectedprice", listofprice);
                        sharedPreferences.setStringList("selectedprice", listofprice);
                        print(sharedPreferences.getStringList("selectedprice"));
                        print(sharedPreferences.getStringList("selected"));
                        print( _selectedItems);
                        _selectedItemsprice.add(price[index]);
                       gotocart();
                      }
                      else {
                        showDialog(context: context, builder: (context) {
                          return add(modifiers: modifiers);
                        });
                      }
                    }
                );
              })
      );
    }
    Future<void> gotocart() async {
      SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            CartScreen(
              selectedItems: sharedPreferences.getStringList("selected")??[],
              selectedItemsprice: sharedPreferences.getStringList("selectedprice")??[],)),
      );
    }
  }

