import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class searchCustomer extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return PerformSearch();
  }
}
class PerformSearch extends State<searchCustomer>
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Padding(padding: EdgeInsets.all(10),
      child:Column(
        children: [
          Container(
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Color(0xFFFFD45F),
              borderRadius: BorderRadius.circular(20)
            ),
            child:TextFormField(
            decoration: InputDecoration(
              labelText: "Search Customer",
            ),
          ),)
        ],
      ),
      ),
    );
  }

}