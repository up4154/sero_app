import 'dart:convert';
//import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:sero_app/productdetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:sero_app/personaldetails.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:sero_app/searchproduct.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final TextEditingController _controller = new TextEditingController();
  List<dynamic> _list=[];
  bool _isSearching=false;
  List<String> searchresult = [];
  TextStyle style = TextStyle(fontSize: 15.0);
  List<String>? _selectedItems = [];
  List<String>? _selectedItemsprice = [];
  var _searchText;
  var _datalist=[];
  var _images=[];
  var _print=[];
  bool _isloading=false;
  var v;
  bool value = false;
  bool value1 = false;
  _CategoryScreenState() {
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
  Future<void> _scanQR() async {
      String barcodeScanRes;
      // Platform messages may fail, so we use a try/catch PlatformException.
      try {
        barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE);
        print(barcodeScanRes);
      } on PlatformException {
        barcodeScanRes = 'Failed to get platform version.';
      }

      // If the widget was removed from the tree while the asynchronous platform
      // message was in flight, we want to discard the reply rather than calling
      // setState to update our non-existent appearance.
      if (!mounted) return;
    /*try {
       String qrResult = await BarcodeScanner.scan().toString();
       print(qrResult);
     }on PlatformException catch(e){
       if(e.code==BarcodeScanner.cameraAccessDenied)
         {
           print("Camera Permission Denied");
        }
      else{
         print(e.message);
       }
     }on FormatException{
       print("You have pressed back button");
     }catch(e){
       print(e.toString());
     }*/

   }
  Future<void> get() async {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    if(mounted){
    setState(() {
      _isloading=true;
    });}
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
    if(mounted){
    setState(() {
      _isloading=false;
    });}
  }
  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
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
  @override
  void initState() {
    get();
    _isSearching = false;
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

                                   suffixIcon: IconButton(
                                     icon:Icon(Icons.qr_code),
                                     onPressed:_scanQR,
                                     color: Colors.black,
                                   )
                                 ),
                                   onChanged: (value){
                                     _handleSearchStart();
                                     searchOperation(value);
                                   }
                               ),),
                               // GestureDetector(child:Icon(Icons.search),
                               //   onTap: (){
                               //        Navigator.push(
                               //        context,
                               //        MaterialPageRoute(
                               //        builder: (context) => searchproduct()));
                               //   },
                               // ),
                               //
                               // Text(
                               //   "Search Category",
                               //   textAlign: TextAlign.center,
                               //   style: TextStyle(
                               //     fontSize: 15,
                               //   ),
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
          child: CircularProgressIndicator(color: Color(0xff000066),)):searchresult.length != 0 || _controller.text.isNotEmpty?
      Center(
        child:ListView.builder(
          itemCount: searchresult.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(child:Container(
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
                      child:Text(searchresult[index],
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

                      } ,
                    ),
                  )
                ],
              ),

            ),
              onTap:() async {
                SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
                _selectedItemsprice!.addAll(sharedPreferences.getStringList("selected")??[]);
                print(_selectedItemsprice);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SelectItem(category:searchresult[index],selectedItemsprice:_selectedItemsprice??[],selectedItems: _selectedItems??[],)));
              } ,
            );
          },
          // SizedBox(
          //   height: 20,
          // ),

        ),
      )://No search found then
      Center(
        child:ListView.builder(
            itemCount: _datalist.length,
             itemBuilder: (BuildContext context, int index) {
               return GestureDetector(child:Container(
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

                             } ,
                           ),
                         )
                       ],
                   ),

               ),
               onTap:() async {
                 SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
                 //_selectedItemsprice!.addAll(sharedPreferences.getStringList("selected")??[]);
                 print(_selectedItemsprice);
                 Navigator.push(
                     context,
                     MaterialPageRoute(
                         builder: (context) => SelectItem(category:_datalist[index],selectedItemsprice:_selectedItemsprice??[],selectedItems: _selectedItems??[],)));
               } ,
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
