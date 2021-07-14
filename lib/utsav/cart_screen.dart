import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sero_app/utsav/payment_screen.dart';
import 'package:sero_app/utsav/void.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartScreen extends StatefulWidget {
  List<String> selectedItems = [];
  List<String> selectedItemsprice = [];
  CartScreen({ Key? key,
    required this.selectedItems
    ,required this.selectedItemsprice,}) : super(key: key);
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<String> selectedItems = [];
  List<String> selectedItemsprice = [];
  double paymentAmount=200.00;
  double discount =0.0;
  bool _isloading =false;
  int points=0;
  int _currentIndex = 0;
  var size,height,width;
  int _counter =1;
  int table_id=0;
  String table_name='';
  setBottomBarIndex(index){
    setState(() {
      _currentIndex = index;
    });
  }
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  void _decrementCounter() {
    setState(() {
      if(_counter>1)
      _counter--;
    });
  }
  Future<void> getSharedPrefs() async {
    setState(() {
       _isloading =true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    table_id=  prefs.getInt("table_id")!;
    table_name =prefs.getString("table_name")!;
    setState(() {
      _isloading =false;
    });
  }
  @override
  void initState()  {
    getSharedPrefs();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    selectedItems =widget.selectedItems;
    selectedItemsprice =widget.selectedItemsprice;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      bottomNavigationBar:BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 70,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              // button 1
              IconButton(
                icon: Icon(Icons.home_sharp,
                  color: _currentIndex == 0 ? Color(0xFFFFD45F) : Colors.grey[800],
                ),
                onPressed: (){
                  setBottomBarIndex(0);
                },
                splashColor: Colors.white,
              ),

              // button 2
              IconButton(
                  icon: Icon(Icons.border_all_rounded,
                    color: _currentIndex == 1 ? Color(0xFFFFD45F) : Colors.grey[800],
                  ),
                  onPressed: (){
                    setBottomBarIndex(1);
                  }),

              // button 3
              IconButton(
                  icon: Icon(Icons.shopping_cart,
                    color: _currentIndex == 2 ? Color(0xFFFFD45F) : Colors.grey[800],
                  ),
                  onPressed: (){
                    setBottomBarIndex(2);
                  }),

              // button 4
              IconButton(
                  icon: Icon(Icons.open_in_browser_sharp,
                    color: _currentIndex == 3 ? Color(0xFFFFD45F) : Colors.grey[800],
                  ),
                  onPressed: (){
                    setBottomBarIndex(3);
                  }),
            ],
          ),
        ),
      ),
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
                child: Row(
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
                    Text("ORDER",
                      style: TextStyle(fontSize: 23,fontWeight: FontWeight.w500),),
                    CircleAvatar(
                        backgroundImage: NetworkImage('https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500')
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 12,left: 25,right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(table_name,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15
                      ),),
                    Text('John Smith',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15
                      ),),
                  ],
                ),
              ),
            ),
          ]
        ),
        toolbarHeight: 170,
        backgroundColor: Colors.white,
      ),
      body: _isloading?Center(child:CircularProgressIndicator(color: Color(0xff000066),)):BodyLayout( selectedItems: selectedItems,selectedItemsprice: selectedItemsprice,),
      bottomSheet:_currentIndex == 3 ? new Container(
        height: 70,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: const Offset(
                1.0,
                1.0,
              ), //Offset
              blurRadius: 6.0,
              spreadRadius: 2.0,
            ), //BoxShadow
            BoxShadow(
              color: Colors.white,
              offset: const Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ),],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                IconButton(
                  onPressed:(){
                  setState(() {
                  });
                },
                  iconSize: 25,
                  icon: Icon(Icons.table_chart_outlined,
                    color: Colors.grey[800],
                ),
                ),
                Text('Tables',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),)
              ],
            ),
            Column(
              children: [
                IconButton(
                  onPressed:(){
                    setState(() {
                    });
                  },
                  iconSize: 29,
                  icon: Icon(Icons.play_arrow_sharp,
                    color: Colors.grey[800],
                  ),
                ),
                Text('Resume',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                )
              ],
            ),Column(
              children: [
                IconButton(
                  onPressed:(){
                    showDialog(
                        context: context,
                        builder: (context){
                          return VoidBill(Ammount: paymentAmount,);
                        }
                    );
                  },
                  iconSize: 25,
                  icon: Icon(Icons.delete,
                    color: Colors.grey[800],
                  ),
                ),
                Text('Void',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),)
              ],
            ),Column(
              children: [
                IconButton(
                  onPressed:(){
                    setState(() {
                    });
                  },
                  iconSize: 25,
                  icon: Icon(Icons.clear_all_sharp,
                    color: Colors.grey[800],
                  ),
                ),
                Text('Clear',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),)
              ],
            ),
            Column(
              children: [
                IconButton(
                  onPressed:(){
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                  iconSize: 40,
                  icon: Icon(Icons.keyboard_arrow_down_outlined,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),

          ],
        ),
      ): Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topRight:Radius.circular(25),topLeft:Radius.circular(25),),
          color :const Color(0xFFFFD45F),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: const Offset(
                1.0,
                1.0,
              ), //Offset
              blurRadius: 6.0,
              spreadRadius: 2.0,
            ), //BoxShadow
            BoxShadow(
              color: Colors.white,
              offset: const Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ),],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: OutlinedButton.icon(
                onPressed: () {
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))
                    ),
                    side: MaterialStateProperty.all(BorderSide(width: 2))
                ),
                icon: Icon(Icons.pause_outlined,
                  color: Colors.black87,),
                label: Text("HOLD",style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20
                ),),
              ),
            ),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentScreen(Ammount: paymentAmount, Balance: paymentAmount,Discountt: discount, Redeem: points,)),
                );
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))
                ),
                side: MaterialStateProperty.all(BorderSide(width: 2))
                ),
              icon: Icon(Icons.payment,
              color: Colors.black87,),
              label: Text("PAY:\$$paymentAmount",style: TextStyle(
                color: Colors.black87,
                fontSize: 20
              ),),
            )
          ],
        ),
      )
    );
  }
}

class BodyLayout extends StatelessWidget {
  List<String> selectedItems = [];
  List<String> selectedItemsprice = [];
  BodyLayout({ Key? key,
    required this.selectedItems
    ,required this.selectedItemsprice,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: selectedItems.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(selectedItems[index]+selectedItemsprice[index]),
        );
      },
    );
  }
}


