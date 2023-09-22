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
  final List selectedTab = [
    const HomeScreen(),
    FavoriteScreen(),
    const ProfileScreen(),
    const Testt()
  ];

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
