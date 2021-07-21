import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sero_app/homescreen.dart';

class CustomWidgetExample extends StatefulWidget {
  CustomWidgetExample({Key  ? key}) : super(key: key);

  @override
  _CustomWidgetExampleState createState() => _CustomWidgetExampleState();
}
BuildContext? testContext;

class _CustomWidgetExampleState extends State<CustomWidgetExample> {
  PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [
      HomeScreen(
         title: 'blah',
      ),
      HomeScreen(
        title: 'blah',
      ),HomeScreen(
        title: 'blah',
      ),HomeScreen(
        title: 'blah',
      ),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          icon: Icon(Icons.home_sharp),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.border_all_rounded),
        activeColorPrimary: Colors.teal,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.shopping_cart),
        activeColorPrimary: Colors.deepOrange,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.open_in_browser_sharp),
        activeColorPrimary: Colors.indigo,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Navigation Bar Demo')),
      drawer: Drawer(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('This is the Drawer'),
            ],
          ),
        ),
      ),
      body: PersistentTabView.custom(
        context,
        controller: _controller,
        screens: _buildScreens(),
        confineInSafeArea: true,
        itemCount: 5,
        handleAndroidBackButtonPress: true,
        stateManagement: true,
        hideNavigationBar: _hideNavBar,
        screenTransitionAnimation: ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        customWidget: CustomNavBarWidget(
          items: _navBarsItems(),
          onItemSelected: (index) {
            setState(() {
              _controller.index = index; // THIS IS CRITICAL!! Don't miss it!
            });
          },
          selectedIndex: _controller.index,
        ),
      ),
    );
  }
}
