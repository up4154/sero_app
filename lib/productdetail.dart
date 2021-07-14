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
  SelectItem({Key ? key,required this.category});

  @override
  State<SelectItem> createState() => _SelectItemState();
}

class _SelectItemState extends State<SelectItem> {
    var v;
    //List<String> selectedReportList = [];
    List<String> images = [];
    List<String> price=[];
    List<String> _selectedItems = [];
    List<String> _selectedItemsprice = [];
    List<String> name = [];
    List<String> id = [];
    bool _isloading = false;
    Future<void> get() async {
      setState(() {
        _isloading = true;
      });
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
    @override
    Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            title: Text(widget.category), /*'Select your food item'-*/
            backgroundColor: Color(0xffffd45f),
          ),
          body: _isloading?Center(child:CircularProgressIndicator(color: Color(0xff000066),)):GridView.builder(
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
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 6,
                      ),
                      Container(
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
                    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
                    print(id[index]);
                  http.Response response = await http.get(
                    Uri.parse("https://pos.sero.app/connector/api/product/${id[index]}")
      , headers: {
                    'Authorization':
                    sharedPreferences.getString("Authorization") ?? ''

                  });
                  var v = (json.decode(response.body));
                  //print(v["data"][0]["modifiers"]);
                   List<dynamic> check=v["data"][0]["modifiers"];
                  List<String> modifiers=[];
                  if(!check.isEmpty){
                    for (var _mod in v["data"][0]["modifiers"][0]) {
                      print(_mod["name"]);
                      modifiers.add(_mod["name"]);
                    }
                  }
                  if(modifiers.isEmpty)
                    {
                      _selectedItems.add(name[index]);
                      _selectedItemsprice.add(price[index]);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CartScreen(selectedItems: _selectedItems,selectedItemsprice: _selectedItemsprice,)),
                      );
                    }
                  else {
                    showDialog(context: context, builder: (context) {
                      return add(modifiers: modifiers);
                    });
                  }
                  }

                    /*showDialog(context: context, builder: (context)
              {
                return Container(
                    padding: EdgeInsets.only(left:20,right: 20),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height/4,
                          width: MediaQuery.of(context).size.height/2 ,
                          color: Colors.white,
                          child: ,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height/4,
                          color: Colors.white,
                        ),
                       Material(
                         borderRadius: BorderRadius.circular(20),
                           child:MaterialButton(onPressed:(){print("Hi");},
                       child: Icon(Icons.arrow_forward),
                         color: Color(0xfffdd460),
                      ))
                      ],
                    ));
              });*/
                    /*showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          //Here we will build the content of the dialog
                          return Column(children: [
                            Dialog(
                                child: Padding(padding: EdgeInsets.all(30),
                                    child: Column(children: [
                                      Center(child: Text("MODIFIERS",
                                        style: TextStyle(
                                            color: Colors.pink),),),
                                      Container(
                                        //backgroundColor: Colors.white,
                                        child: MultiSelectChip(
                                          reportList,
                                          onSelectionChanged: (selectedList) {
                                            setState(() {
                                              selectedReportList = selectedList;
                                            });
                                          },

                                        ),

                                      )
                                    ]))),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50)
                              ),
                              child: AlertDialog(
                                title: Text("Addons",),
                                content: MultiSelectChip(
                                  reportList,
                                  onSelectionChanged: (selectedList) {
                                    setState(() {
                                      selectedReportList = selectedList;
                                    });
                                  },
                                ),

                              ),),

                            FlatButton(
                              color: Color(0xfffdd460),
                              child: Icon(Icons.arrow_forward),
                              onPressed: () => Navigator.of(context).pop(),
                            )
                          ]);
                        });*/
                    /*Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => add()));
            }
            );*/


                  /*
            Container(
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
              ),
              padding: const EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 6,
                  ),
                  new SvgPicture.asset(
                    'asset/thai food.svg',
                    height: 60.0,
                    width: 60.0,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Thai",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ],
              ),
            ),
            Container(
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
              ),
              padding: const EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 6,
                  ),
                  new SvgPicture.asset(
                    'asset/noodles.svg',
                    height: 60.0,
                    width: 60.0,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Noodles",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ],
              ),
            ),
            Container(
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
              ),
              padding: const EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 6,
                  ),
                  new SvgPicture.asset(
                    'asset/fried rice.svg',
                    height: 60.0,
                    width: 60.0,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Chinese",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ],
              ),
            ),
          ],*/
                );
              }));
    }
  }

// class ContainerEdit extends StatefulWidget {
//   ContainerEdit({@required this.text, @required this.img});
//   final String text;
//   final Image img;
//   @override
//   _ContainerEditState createState() => _ContainerEditState();
// }
//
// class _ContainerEditState extends State<ContainerEdit> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 5,
//             blurRadius: 7,
//             offset: Offset(0, 3), // changes position of shadow
//           ),
//         ],
//       ),
//       padding: const EdgeInsets.all(8),
//       child: Column(
//         children: <Widget>[
//           SizedBox(
//             height: 6,
//           ),
//           new SvgPicture.asset(
//             'img',
//             height: 60.0,
//             width: 60.0,
//           ),
//           SizedBox(
//             height: 4,
//           ),
//           Text(
//             widget.text,
//             style: TextStyle(color: Colors.black, fontSize: 20),
//           ),
//         ],
//       ),
//     );
//   }
// }
