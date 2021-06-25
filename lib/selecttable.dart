import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sero_app/productdetail.dart';
import 'package:http/http.dart' as http;

class SelectTable extends StatefulWidget {
  const SelectTable({Key key}) : super(key: key);

  @override
  State<SelectTable> createState() => _SelectTableState();
}

class _SelectTableState extends State<SelectTable> {
  Map mapResponse;
  List listofData;
  Future fetchData() async {
    http.Response response;
    response = await http.get('https://pos.sero.app/connector/api/table.json');
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);
        listofData = mapResponse['data'];
      });
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Select table'),
          backgroundColor: Colors.yellow.shade200,
        ),
        body: mapResponse == null
            ? Container()
            : GridView.count(
                shrinkWrap: true,
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 25,
                mainAxisSpacing: 25,
                crossAxisCount: 3,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Icon(
                          Icons.table_chart,
                          size: 50,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          listofData[0]['name'].toString(),
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                    color: Colors.yellow,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Icon(
                          Icons.table_chart,
                          size: 50,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Table 2",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                    color: Colors.green,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Icon(
                          Icons.table_chart,
                          size: 50,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Table 3",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                    color: Colors.red,
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
                                builder: (context) => SelectItem()),
                          );
                        },
                        child: Text(
                          "Next",
                          textAlign: TextAlign.center,
                        )),
                  ),
                ],
              ));
    // bottomNavigationBar: BottomNavigationBar(
    //   items: const <BottomNavigationBarItem>[
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.home),
    //       label: 'home',
    //     ),
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.business),
    //       label: 'business',
    //     ),
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.school),
    //       label: 'school',
    //     ),
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.shopping_cart),
    //       label: 'cart',
    //     ),
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.person),
    //       label: 'Profile',
    //     ),
    //   ],
    //   currentIndex: _selectedIndex,
    //   unselectedItemColor: Colors.grey,
    //   showUnselectedLabels: true,
    //   selectedItemColor: Colors.amber[800],
    //   onTap: _onItemTapped,
    // ),
  }
}
