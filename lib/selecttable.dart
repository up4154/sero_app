import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectTable extends StatefulWidget {
  const SelectTable({Key key}) : super(key: key);

  @override
  State<SelectTable> createState() => _SelectTableState();
}

class _SelectTableState extends State<SelectTable> {
  // int _selectedIndex = 0;
  // static const TextStyle optionStyle =
  //     TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  // static const List<Widget> _widgetOptions = <Widget>[
  //   Text(
  //     'Index 0: Home',
  //     style: optionStyle,
  //   ),
  //   Text(
  //     'Index 1: Business',
  //     style: optionStyle,
  //   ),
  //   Text(
  //     'Index 2: School',
  //     style: optionStyle,
  //   ),
  //   Text(
  //     'Index 3: Cart',
  //     style: optionStyle,
  //   ),
  //   Text(
  //     'Index 4: My profile',
  //     style: optionStyle,
  //   ),
  // ];
  //
  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Select table'),
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
              padding: const EdgeInsets.all(8),
              child: const Text("Table 1"),
              color: Colors.yellow,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: const Text('Table 2'),
              color: Colors.green,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: const Text('Table 3'),
              color: Colors.yellow,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: const Text('Table 4'),
              color: Colors.red,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: const Text('Table 5'),
              color: Colors.yellow,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: const Text('Table 6'),
              color: Colors.green,
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
