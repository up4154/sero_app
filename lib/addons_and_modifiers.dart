import 'package:flutter/material.dart';
import 'package:sero_app/utsav/cart_screen.dart';

class add extends StatefulWidget {
  add({required this.modifiers});
  List<dynamic> modifiers;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<add> {
   List<dynamic> _cast =[];
  final List<String> _selectedModifiers = <String>[];

  Iterable<Widget> get actorWidgets sync* {
    for (int actor=0;actor<_cast.length;actor++/*final Modifiers actor in _cast*/) {
      yield Padding(
          padding: const EdgeInsets.all(4.0),
          child: FilterChip(
            backgroundColor: Color(0xFFFFD45F),
            //avatar: CircleAvatar(child: Text(actor.initials)),
            label: Text(_cast[actor]),
            checkmarkColor: Colors.blue,
            selectedColor: Colors.yellow,
            selected: _selectedModifiers.contains(_cast[actor]),
            showCheckmark: true,
            onSelected: (bool value) {
              setState(() {
                if (value) {
                  _selectedModifiers.add(_cast[actor]);
                  print(_cast[actor]);
                } else {
                  _selectedModifiers.removeWhere((String name) {
                    return name == _cast[actor];
                  });
                }
              });
            },
          ));
    }}
  @override
  Widget build(BuildContext context) {
    _cast=widget.modifiers;
     return Container(
         //elevation: 16,
       color: Colors.transparent,
         child:Column(
           mainAxisAlignment: MainAxisAlignment.center,
             children:[Dialog(
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          insetPadding: EdgeInsets.all(20),
          child:Column(
              children:[
                Container(margin:EdgeInsets.all(15),child:Center(child: Text("Modifiers",style: TextStyle(fontSize: 20),),),),
                Wrap(direction: Axis.horizontal,
                    children: actorWidgets.toList()),

              ])
      ),
        Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            insetPadding: EdgeInsets.all(20),
            child:Column(
                children:[
                  Container(margin:EdgeInsets.all(15),child:Center(child: Text("AddOns",style: TextStyle(fontSize: 20),),),),
                  Wrap(direction: Axis.horizontal,
                      children: actorWidgets.toList()),

                ])
        ),
               FlatButton(onPressed: (){
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => CartScreen()
                   ),
                 );
                 print(_selectedModifiers);
                 },
                   color: Color(0xFFFFD45F),
                   child: Icon(Icons.arrow_forward))
      ]));
  }
  }


class Modifiers {
  const Modifiers(this.name);
  final String name;
}