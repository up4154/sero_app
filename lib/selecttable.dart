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
  List<String> _tablenos = ["", "", ""];
  _SelectTableState() {
    fetchData().then((val) => setState(() {
          _tablenos = val;
        }));
  }
  Future<List<String>> fetchData() async {
    Map data = await getData();
    List<String> tableno = [
      data['data'][0]['name'],
      data['data'][1]['name'],
      data['data'][2]['name']
    ];
    return tableno;
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
        body: GridView.count(
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
                    _tablenos[0],
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
                    _tablenos[1],
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
                    _tablenos[2],
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
                  onPressed: () {},
                  child: Text(
                    "Next",
                    textAlign: TextAlign.center,
                  )),
            ),
          ],
        ));
  }
}

Future<Map<String, dynamic>> getData() async {
  String myUrl = "https://pos.sero.app/connector/api/table";
  http.Response response = await http.get(myUrl, headers: {
    'Authorization':
        'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjlhNTYwNGYxZDAxMzU2NTRhY2YyYjE4MmEyOGUwMjA4M2QxOGUxY2Y1ZTY0MzM1MzdmNzc3MzFkMTMzZjNmNWQ5MTU3ZTEwOTQ5NDE3ZmQ3In0.eyJhdWQiOiIzIiwianRpIjoiOWE1NjA0ZjFkMDEzNTY1NGFjZjJiMTgyYTI4ZTAyMDgzZDE4ZTFjZjVlNjQzMzUzN2Y3NzczMWQxMzNmM2Y1ZDkxNTdlMTA5NDk0MTdmZDciLCJpYXQiOjE2MjM2NjAxMzksIm5iZiI6MTYyMzY2MDEzOSwiZXhwIjoxNjU1MTk2MTM5LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.WGLAu9KVi-jSt0q9yUyENDoEQnSLF1o0tezej5YozBFXJVQuEvSykvA9T6nnJghujQ2uU-nxUCRftLBhYzGjsu26YoKZBin70k1cqoYDfIWlVZ-fNkJi1vAXYOk9Pzxz7YFBa6hgz1MyUlDOI1LsSSsJh87hGBzIN6Ib_cYmGoo8KHVEfqbDtCNnZdOq68vjhwf6dwYEJUtxanaocuC-_XHkdM7769JiO48Ot93BqZjmRuVwvK9zE_8bilmhktlgD65ahgKOSS2yQlMdpgpsqP1W5Mfy_SBu32BkqTpAc5v2QWRTVhevES-blsfqdoZ59aw0OzrxyC8PvipyuhGQjs6V7eCrKK0jOei9g4RyhKlQueDXxxrWrqsStIsPzkn-kXA5k2NINIFgr2MlLtypTR76xnncWE5rCqm39K5V2_q3aXDQvCHdl3SVBKDqwNCUKq1CxbJlkF8r1R1mxXxN76TBZbcalO7wUX0F-D1j9oWkwXSZBe7L6vQQqvhC2AsQO2LB4QiByuFi1-J4h05vM3Kab0nmRvVeNYekhNP9HtTGWCH_UDuiDAp23VqUhMTrFygUAPEASU0fnw-rMKhrll_O0wMaBE33ZfItsV0o6pHCQhUjsDKwfmgVynOyYu0rX_huVN_PUBSYQVuCiabUMp8Q5Dv7n8Ky7_yI8XypQK4'
  });
  return json.decode(response.body);
}
