import 'package:adminapp/screens/drivers/drivers_list__view.dart';
import 'package:adminapp/screens/home_screen/home_view.dart';
import 'package:adminapp/screens/orders_screen/orders_list_view.dart';
import 'package:adminapp/screens/users/users_list_view.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class NavBarView extends StatefulWidget {
  const NavBarView({Key? key}) : super(key: key);

  @override
  State<NavBarView> createState() => _NavBarViewState();
}

class _NavBarViewState extends State<NavBarView> {
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  static final List<Widget> _widgetOptions = [
    const HomeView(),
    UsersListView(),
    const OrdersListView(),
    const DriversListView(),
  ];
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.orangeAccent,
        key: _bottomNavigationKey,
        index: _selectedIndex,
        height: 60,
        items: <Widget>[
          Image.asset("images/category.png"),
          Image.asset("images/group.png"),
          Image.asset("images/order.png"),
          Image.asset("images/delivery.png"),
        ],
        onTap: _onItemTapped,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
