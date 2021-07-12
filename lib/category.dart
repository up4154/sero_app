import 'dart:convert';
import 'package:sero_app/productdetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:sero_app/personaldetails.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  TextStyle style = TextStyle(fontSize: 15.0);
  var _datalist=[];
  var _images=[];
  var _print=[];
  bool _isloading=false;
  var v;
  bool value = false;
  bool value1 = false;
  // Future _scanQR() async {
  //   try {
  //     String qrResult = await BarcodeScanner.scan().toString();
  //     print(qrResult);
  //   }on PlatformException catch(e){
  //     if(e.code==BarcodeScanner.cameraAccessDenied)
  //       {
  //         print("Camera Permission Denied");
  //       }
  //     else{
  //       print(e.message);
  //     }
  //   }on FormatException{
  //     print("You have pressed back button");
  //   }catch(e){
  //     print(e.toString());
  //   }
  //
  // }
  Future<void> get() async {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    setState(() {
      _isloading=true;
    });
    int i=1;
    do{
    http.Response response = await http.get(
        Uri.parse("https://pos.sero.app/connector/api/variation/?page=$i"), headers: {
      'Authorization':
      sharedPreferences.getString("Authorization")?? ''
    });
    v = (json.decode(response.body));
    print("curr+"+v["meta"]["current_page"].toString());
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
    setState(() {
      _isloading=false;
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
                      setState(() {
                      });
                    },
                  ),
                  Text("Category",
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
                           padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                           onPressed: () {},
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: <Widget>[
                               GestureDetector(child:Icon(Icons.search),
                                 onTap: (){
                                 },
                               ),

                               Text(
                                 "Search Product",
                                 textAlign: TextAlign.center,
                                 style: TextStyle(
                                   fontSize: 15,
                                 ),
                               ),

                               // GestureDetector(child:Icon(Icons.qr_code),
                               //   onTap: _scanQR,
                               // ),
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
      body: _isloading?Center(
          child: CircularProgressIndicator(color: Color(0xff000066),)):Center(
        child: ListView.builder(
            itemCount: _datalist.length,
             itemBuilder: (BuildContext context, int index) {
               return Container(
                 height: MediaQuery.of(context).size.height/10,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(10.0),
                   color: Colors.white,
                   boxShadow: [
                 BoxShadow(
                 color: Colors.grey,
                   offset: const Offset(
                     2.0,
                     2.0,
                   ),
                   blurRadius: 2.0,
                   spreadRadius: 1.0,
                 ),
                 ]//BoxShadow
               ),
                   margin: EdgeInsets.all(10),
                   width: MediaQuery.of(context).size.width/1.5,
                   child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                         Container(
                             //child:Image.network(_images[index],height: 30,width:MediaQuery.of(context).size.width/4.5,)),
                        /* SizedBox(
                           width: 15,
                         ),*/),
                         Container(
                             width: MediaQuery.of(context).size.width/3,
                             child:Text(_datalist[index],
                             softWrap: true,
                             textAlign: TextAlign.center,
                             style: style.copyWith(color: Colors.black))),
                         /*SizedBox(
                           width:50,
                         ),*/
                         Container(
                           width: MediaQuery.of(context).size.width/3,
                           child:  IconButton(icon:Icon(
                             Icons.arrow_forward,
                           ),
                             onPressed:(){
                               Navigator.push(
                                   context,
                                   MaterialPageRoute(
                                       builder: (context) => SelectItem(category:_datalist[index])));
                             } ,
                           ),
                         )
                       ],
                   )
               );
             },
              // SizedBox(
              //   height: 20,
              // ),

          ),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}
