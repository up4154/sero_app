import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sero_app/personaldetails.dart';
import 'package:http/http.dart' as http;

class CategoryScreen extends StatefulWidget {
  CategoryScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  TextStyle style = TextStyle(fontSize: 15.0);
  var _datalist=List<String>();
  var _images=List<String>();
  var _print=List<String>();
  bool _isloading=false;
  var v;
  bool value = false;
  bool value1 = false;
  Future<void> get() async {
    _isloading=true;
    http.Response response = await http.get(
        "https://pos.sero.app/connector/api/product", headers: {
      'Authorization':
      'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjlhNTYwNGYxZDAxMzU2NTRhY2YyYjE4MmEyOGUwMjA4M2QxOGUxY2Y1ZTY0MzM1MzdmNzc3MzFkMTMzZjNmNWQ5MTU3ZTEwOTQ5NDE3ZmQ3In0.eyJhdWQiOiIzIiwianRpIjoiOWE1NjA0ZjFkMDEzNTY1NGFjZjJiMTgyYTI4ZTAyMDgzZDE4ZTFjZjVlNjQzMzUzN2Y3NzczMWQxMzNmM2Y1ZDkxNTdlMTA5NDk0MTdmZDciLCJpYXQiOjE2MjM2NjAxMzksIm5iZiI6MTYyMzY2MDEzOSwiZXhwIjoxNjU1MTk2MTM5LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.WGLAu9KVi-jSt0q9yUyENDoEQnSLF1o0tezej5YozBFXJVQuEvSykvA9T6nnJghujQ2uU-nxUCRftLBhYzGjsu26YoKZBin70k1cqoYDfIWlVZ-fNkJi1vAXYOk9Pzxz7YFBa6hgz1MyUlDOI1LsSSsJh87hGBzIN6Ib_cYmGoo8KHVEfqbDtCNnZdOq68vjhwf6dwYEJUtxanaocuC-_XHkdM7769JiO48Ot93BqZjmRuVwvK9zE_8bilmhktlgD65ahgKOSS2yQlMdpgpsqP1W5Mfy_SBu32BkqTpAc5v2QWRTVhevES-blsfqdoZ59aw0OzrxyC8PvipyuhGQjs6V7eCrKK0jOei9g4RyhKlQueDXxxrWrqsStIsPzkn-kXA5k2NINIFgr2MlLtypTR76xnncWE5rCqm39K5V2_q3aXDQvCHdl3SVBKDqwNCUKq1CxbJlkF8r1R1mxXxN76TBZbcalO7wUX0F-D1j9oWkwXSZBe7L6vQQqvhC2AsQO2LB4QiByuFi1-J4h05vM3Kab0nmRvVeNYekhNP9HtTGWCH_UDuiDAp23VqUhMTrFygUAPEASU0fnw-rMKhrll_O0wMaBE33ZfItsV0o6pHCQhUjsDKwfmgVynOyYu0rX_huVN_PUBSYQVuCiabUMp8Q5Dv7n8Ky7_yI8XypQK4'
    });
    v = (json.decode(response.body));
    for(var i in v["data"])
      {
        _datalist.add(i["name"]);
        print(i["image_url"]);
        _images.add(i["image_url"]);
      }
    _print.addAll(_datalist);
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
              color :const Color(0xFFFFD45F),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                       child:Material(
                         elevation: 5.0,
                         borderRadius: BorderRadius.circular(30.0),
                         color: Colors.white,
                         child: MaterialButton(
                           minWidth:270,
                           padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                           onPressed: () {},
                           child: Row(
                             children: <Widget>[
                               GestureDetector(child:Icon(Icons.search),
                                 onTap: (){

                                 },
                               ),
                               SizedBox(
                                 width: 10,
                               ),
                               Text(
                                 "Search Customer",
                                 textAlign: TextAlign.center,
                                 style: TextStyle(
                                   fontSize: 15,
                                 ),
                               ),
                               SizedBox(
                                 width: 40,
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
                     ),
                    ],
                  )
                ],
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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.builder(
            itemCount: _print.length,
             itemBuilder: (BuildContext context, int index) {
               return Container(
                   margin: EdgeInsets.only(top:20),
                   child:Material(
                 elevation: 5.0,
                 borderRadius: BorderRadius.circular(30.0),
                 color: Colors.white,
                 child: MaterialButton(
                     minWidth: MediaQuery.of(context).size.width,
                     padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                     onPressed: () {},
                     child: new Row(
                       children: [
                         Container(
                           height: 60,
                             width:30,
                             child:Image.network(_images[index],height: 30,width: 60,)),
                         SizedBox(
                           width: 15,
                         ),
                         Container(
                             width: 150,
                             child:Text(_print[index],
                             softWrap: true,
                             textAlign: TextAlign.center,
                             style: style.copyWith(color: Colors.black))),
                         SizedBox(
                           width:50,
                         ),
                         Icon(
                           Icons.arrow_forward,
                         ),
                       ],
                     )),
                   )
               );
             },
              // SizedBox(
              //   height: 20,
              // ),

          ),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

}
