import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sero_app/category.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectItem extends StatefulWidget {
  const SelectItem({Key key}) : super(key: key);

  @override
  State<SelectItem> createState() => _SelectItemState();
}

class _SelectItemState extends State<SelectItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Select your food item'),
          backgroundColor: Colors.yellow.shade200,
        ),
        body: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 25,
          mainAxisSpacing: 25,
          crossAxisCount: 3,
          children: <Widget>[
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
                    'asset/burger.svg',
                    height: 60.0,
                    width: 60.0,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Burger",
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
                    'asset/pizza.svg',
                    height: 60.0,
                    width: 60.0,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Pizza",
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
                    'asset/coke.svg',
                    height: 60.0,
                    width: 60.0,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Coke",
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
                    'asset/fish.svg',
                    height: 60.0,
                    width: 60.0,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Fish",
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
                    'asset/cake.svg',
                    height: 60.0,
                    width: 60.0,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Cake",
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
                    'asset/juice.svg',
                    height: 60.0,
                    width: 60.0,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Drinks",
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
                    'asset/coffee_cup.svg',
                    height: 60.0,
                    width: 60.0,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Choco",
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
                    'asset/ramen.svg',
                    height: 60.0,
                    width: 60.0,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Ramen",
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
                    'asset/coffee.svg',
                    height: 60.0,
                    width: 60.0,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Latte",
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
          ],
        ));
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
