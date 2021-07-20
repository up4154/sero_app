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
  String customer_name="";
  double paymentAmount=200.00;
  double discount =0.0;
  bool _isloading =false;
  List<String> counter=[];
  int points=0;
  int _currentIndex = 0;
  var size,height,width;
  int table_id=0;
  String table_name='';
  setBottomBarIndex(index){
    setState(() {
      _currentIndex = index;
    });
  }

  Future<void> getSharedPrefs() async {
    setState(() {
      _isloading =true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    table_id=  prefs.getInt("table_id")!;
    table_name =prefs.getString("table_name")!;
    customer_name=prefs.getString("customer_name")!;
    selectedItems=prefs.getStringList("selected")!;
    counter=prefs.getStringList("quantity")!;
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
    setState(() {
      selectedItems.clear();
    });

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
            child: Column(
              children: [
                Row(
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
                        onPressed: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          table_id=  prefs.getInt("table_id")!;
                          table_name =prefs.getString("table_name")!;
                          customer_name=prefs.getString("customer_name")!;
                          selectedItems=prefs.getStringList("selected")!;
                          setState(() {
                            _currentIndex =0;

                            setState(() {
                              _isloading =false;
                            });
                            setState(() {
                              setBottomBarIndex(3);
                            });
                          });
                        }),
                  ],
                ),
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
                            backgroundImage:
                            NetworkImage('https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500')
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
                        Text(customer_name,
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
        body: _isloading?Center(child:CircularProgressIndicator(color: Color(0xff000066),))
            :BodyLayout( selectedItems: selectedItems,selectedItemsprice: selectedItemsprice,counterList:counter),
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
                    onPressed:()async{
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      table_id=  prefs.getInt("table_id")!;
                      table_name =prefs.getString("table_name")!;
                      customer_name=prefs.getString("customer_name")!;
                      selectedItems=prefs.getStringList("selected")!;
                      setState(() {
                        _currentIndex =0;

                        setState(() {
                          _isloading =false;
                        });
                        setState(() {

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CartScreen(selectedItems: prefs.getStringList("selected")?? [],selectedItemsprice:[],)),
                          );

                        });
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

class BodyLayout extends StatefulWidget {
  List<String> selectedItems = [];
  List<String> selectedItemsprice = [];
  List<String> counterList;
  BodyLayout({ Key? key,
    required this.selectedItems
    ,required this.selectedItemsprice,
  required this.counterList
  }) : super(key: key);

  @override
  _BodyLayoutState createState() => _BodyLayoutState(selectedItems);
}

class _BodyLayoutState extends State<BodyLayout> {
  _BodyLayoutState(List<String> selectedItems);
  List<String> selectedItems = [];
  int _counter =1;
  @override
  Widget build(BuildContext context) {
    _counter=widget.selectedItems.length;
    return Container(
      height: MediaQuery.of(context).size.height/1.95,
      child: ListView.builder(
        itemCount: widget.selectedItems.length,
        itemBuilder: (context, index) {
          if(widget.counterList.length < widget.selectedItems.length ) {
            widget.counterList.add("1");
          }
          return Padding(
            padding: const EdgeInsets.only(top: 10,left: 8,right: 8),
            child: Container(
                height:MediaQuery.of(context).size.height/10 ,
                padding: EdgeInsets.only(left:10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
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
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width/2.8,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: Text(
                          widget.selectedItems[index],
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.,
                      children: [
                        IconButton(
                          onPressed:(){
                            setState(() {
                              var c=int.parse(widget.counterList[index]);
                              saveState();
                              if( c>1)
                                c--;
                              widget.counterList[index]=c.toString();
                              saveState();
                            });
                          },
                          icon: Icon(Icons.remove_circle,
                            size: 17,),
                        ),
                        Text(widget.counterList[index].toString(),
                          style: TextStyle(
                              fontSize: 15
                          ),
                        ),
                        IconButton(
                          onPressed:(){
                            setState(() {
                              var c=int.parse(widget.counterList[index]);
                              c++;
                              widget.counterList[index]=c.toString();
                              saveState();
                            });
                          },
                          icon: Icon(Icons.add_circle_outlined,
                            size: 17,
                          ),
                        ),
                      ],
                    ),
                    // Container(
                    //     width: MediaQuery.of(context).size.width/9,
                    //     child:Text(
                    //       '\$'+double.parse(widget.selectedItemsprice[index]).toStringAsFixed(2),
                    //       style: TextStyle(
                    //           fontSize: 15,
                    //           fontWeight: FontWeight.bold
                    //       ),
                    //     )),
                    IconButton(
                      onPressed:(){

                      },
                      icon: Icon(Icons.delete,
                        color: Colors.red,
                        size: 25,),
                    ),
                  ],
                )
            ),
          );
        },
      ),
    );
  }

  Future<void> saveState() async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setStringList("quantity",[]);
    prefs.setStringList("quantity",widget.counterList);
  }
}

