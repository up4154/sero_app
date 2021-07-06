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
  List<String> images=['asset/burger.svg','asset/pizza.svg','asset/coke.svg','asset/fish.svg','asset/cake.svg','asset/juice.svg','asset/coffee_cup.svg','asset/ramen.svg','asset/coffee.svg','asset/thai food.svg'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Select your food item'),
          backgroundColor: Colors.yellow.shade200,
        ),
        body: GridView.builder(
          primary: false,
          padding: const EdgeInsets.all(10),
          itemCount: images.length,
          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 25.0,
            mainAxisSpacing: 25.0,

          ),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 550,
              width: 550,
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
                    images[index],
                    height: 50.0,
                    width: 50.0,
                  ),
                  Text(
                    "Burger",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ],
              ),
            );
          },

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
