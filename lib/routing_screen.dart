import 'package:ecommerce_app/screens/home_page.dart';
import 'package:ecommerce_app/screens/profile_screen.dart';
import 'package:ecommerce_app/screens/purchase_screen.dart';
import 'package:ecommerce_app/screens/search_screen.dart';
import 'package:flutter/material.dart';

class RoutingScreen extends StatefulWidget {
  const RoutingScreen({super.key});

  @override
  State<RoutingScreen> createState() => _RoutingScreenState();
}

class _RoutingScreenState extends State<RoutingScreen> {
  late List<Widget> screens;
  late PageController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    screens = [
      const Myhomepage(),
      const Search(),
      const Purchase(),
      const Profile(),
    ];
    _controller = PageController(initialPage: current);
  }

  int current = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _controller,
          children: screens,
        ),
        bottomNavigationBar: NavigationBar(
          backgroundColor: Colors.transparent,
          selectedIndex: current,
          onDestinationSelected: (value) {
            setState(() {
              current = value;
            });
            _controller.jumpToPage(current);
          },
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: 'home'),
            NavigationDestination(icon: Icon(Icons.search), label: 'search'),
            NavigationDestination(
                icon: Badge(label: Text('5'), child: Icon(Icons.store_rounded)),
                label: 'purchase'),
            NavigationDestination(icon: Icon(Icons.person), label: 'profile'),
          ],
        ));
  }
}
