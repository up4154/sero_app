import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sero_app/selecttable.dart';

class PersonalDetails extends StatefulWidget {
  PersonalDetails({Key key}) : super(key: key);
  @override
  _PersonalDetailsState createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  bool value = false;
  bool value1 = false;
  DateTime selectedDate = DateTime.now();
  bool value3 = false;
  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(1950),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Add Customer',
                  style: TextStyle(
                    fontFamily: 'AirbnbCerealExtraBold',
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 13,
              ),
              ConstContainer(
                hintText: 'First Middle Last',
                text: 'Full Name',
              ),
              ConstContainer(
                hintText: 'abc@gmail.com',
                text: 'Email id',
              ),
              ConstContainer(
                hintText: '+987654321',
                text: 'Contact info',
              ),
              ConstContainer(
                  text: 'Home address',
                  hintText:
                      'Flat number, apartment name, locality, city, pin code'),
              ConstContainer(
                hintText: '',
                text: 'Customer group',
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  child: Column(children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Gender',
                    style: TextStyle(
                      fontFamily: 'AirbnbCerealMedium',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(children: <Widget>[
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ), //SizedBox
                      Text(
                        'Female',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'AirbnbCerealMedium',
                          fontWeight: FontWeight.w500,
                        ),
                      ), //Text
                      SizedBox(width: 10), //SizedBox
                      Checkbox(
                        activeColor: Color(0xFF325288),
                        value: this.value,
                        onChanged: (bool value) {
                          setState(() {
                            if (value == true) {
                              value1 = false;
                              this.value = value;
                            }
                          });
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ), //SizedBox
                      Text(
                        'Male',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'AirbnbCerealMedium',
                          fontWeight: FontWeight.w500,
                        ),
                      ), //Text
                      SizedBox(width: 10), //SizedBox
                      Checkbox(
                        activeColor: Color(0xFF325288),
                        value: this.value1,
                        onChanged: (bool value1) {
                          setState(() {
                            if (value1 == true) {
                              value = false;
                              this.value1 = value1;
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ]),
              ])),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Date of birth',
                  style: TextStyle(
                    fontFamily: 'AirbnbCerealMedium',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "${selectedDate.toLocal()}".split(' ')[0],
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'AirbnbCerealBook'),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    SizedBox(
                      width: 60,
                      child: RaisedButton(
                        onPressed: () => _selectDate(context), // Refer step 3
                        child: Icon(
                          Icons.date_range,
                          color: Colors.grey,
                        ),
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.0),
                            side: BorderSide(color: Color(0xFFfad586), width: 1)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 380,
                height: 50,
                child: CupertinoButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SelectTable(),
                        ));
                  },
                  child: Text('Done'),
                  color: Color(0xFFFFD45F),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ConstContainer extends StatelessWidget {
  ConstContainer({@required this.text, @required this.hintText});
  final String text;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              text,
              style: TextStyle(
                fontFamily: 'AirbnbCerealMedium',
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade200,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}

class Item {
  const Item(this.name, this.icon);
  final String name;
  final Icon icon;
}

class DropdownScreen extends StatefulWidget {
  State createState() => DropdownScreenState();
}

class DropdownScreenState extends State<DropdownScreen> {
  Item selectedUser;
  List<Item> users = <Item>[
    const Item(
        'Android',
        Icon(
          Icons.android,
          color: const Color(0xFF167F67),
        )),
    const Item(
        'Flutter',
        Icon(
          Icons.flag,
          color: const Color(0xFF167F67),
        )),
    const Item(
        'ReactNative',
        Icon(
          Icons.format_indent_decrease,
          color: const Color(0xFF167F67),
        )),
    const Item(
        'iOS',
        Icon(
          Icons.mobile_screen_share,
          color: const Color(0xFF167F67),
        )),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF167F67),
          title: Text(
            'Dropdown options',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Center(
          child: DropdownButton<Item>(
            hint: Text("Select item"),
            value: selectedUser,
            onChanged: (Item Value) {
              setState(() {
                selectedUser = Value;
              });
            },
            items: users.map((Item user) {
              return DropdownMenuItem<Item>(
                value: user,
                child: Row(
                  children: <Widget>[
                    user.icon,
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      user.name,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
