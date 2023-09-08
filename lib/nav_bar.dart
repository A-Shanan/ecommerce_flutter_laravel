// ignore_for_file: prefer_const_constructors

import 'package:ecommerce_flutter_laravel/screens/favorite_screen.dart';
import 'package:ecommerce_flutter_laravel/screens/home_screen.dart';
import 'package:ecommerce_flutter_laravel/screens/profile.dart';
import 'package:ecommerce_flutter_laravel/screens/test.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

int _currentIndex = 0;

class _NavBarState extends State<NavBar> {
  // /// Controller to handle PageView and also handles initial page
  // final _pageController = PageController(initialPage: 0);

  // //int maxCount = 5;

  // /// widget list
  final List selectedTab = [
    const HomeScreen(),
    FavoriteScreen(),
    const ProfileScreen(),
    const Testt()
  ];

  // @override
  // void dispose() {
  //   _pageController.dispose();
  //   super.dispose();
  // }

  // @override
  // void initState() {
  //   super.initState();
  // }

  // // var selectedTab = selectedTab.HomeScreen;

  // // void _handleIndexChanged(int i) {
  // //   setState(() {
  // //     selectedTab = selectedTab.values[i];
  // //   });
  // // }

  // // var navigation = [
  // //   HomeScreen(),
  // //   FavoriteScreen(),
  // //   CategoryScreen(),
  // //   MarketScreen(),
  // //   ProfileScreen()
  // // ];
  // final pages = [
  //   const HomeScreen(),
  //   FavoriteScreen(),
  //   CategoryScreen(),
  //   MarketScreen(),
  //   ProfileScreen()
  // ];
  // void changePage(int index) {
  //   setState(() {
  //     _currentIndex = index;
  //   });
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     decoration: BoxDecoration(color: Colors.transparent),
  //     child: Scaffold(
  //       extendBody: true,
  //       body: pages[_currentIndex],
  //       bottomNavigationBar: Padding(
  //         padding: EdgeInsets.only(bottom: 10.0),
  //         child: DotNavigationBar(
  //           //Color(0xffEEAE1C),
  //           backgroundColor: Color.fromARGB(255, 225, 235, 213),
  //           margin: EdgeInsets.only(left: 10.0, right: 10.0),
  //           currentIndex: _currentIndex,
  //           onTap: changePage,
  //           items: [
  //             DotNavigationBarItem(
  //               icon: Icon(Icons.home_outlined),
  //               unselectedColor: Colors.white,
  //               selectedColor: Color(0xffF19C23),
  //             ),
  //             DotNavigationBarItem(
  //               icon: Icon(Icons.favorite_border),
  //               unselectedColor: Colors.white,
  //               selectedColor: Color(0xffF19C23),
  //             ),
  //             DotNavigationBarItem(
  //               icon: Icon(Icons.category_outlined),
  //               unselectedColor: Colors.white,
  //               selectedColor: Color(0xffF19C23),
  //             ),
  //             DotNavigationBarItem(
  //               icon: Icon(Icons.storefront),
  //               unselectedColor: Colors.white,
  //               selectedColor: Color(0xffF19C23),
  //             ),
  //             DotNavigationBarItem(
  //               icon: Icon(Icons.person),
  //               unselectedColor: Colors.white,
  //               selectedColor: Color(0xffF19C23),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          selectedTab[_currentIndex],
          Positioned(
            bottom: 25,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: const Color(0xffEEAE1C),
                ),
                child: BottomNavigationBar(
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  currentIndex: _currentIndex,
                  selectedItemColor: Colors.blue[800],
                  unselectedItemColor: Colors.black,
                  onTap: _onItemTapped,
                  type: BottomNavigationBarType.fixed,
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.favorite),
                      label: 'Favorite',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person_2_outlined),
                      label: 'Profile',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.text_snippet_outlined),
                      label: 'Profile',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// enum _SelectedTab {
//   HomeScreen(),
//   FavoriteScreen(),
//   CategoryScreen(),
//   MarketScreen(),
//   ProfileScreen(),
// }
// navigation=[HomeScreen(), FavoriteScreen(), CategoryScreen(), MarketScreen(),ProfileScreen()]
// body: navigation[_selectedTab]