import 'package:ecommerce_flutter_laravel/nav_bar.dart';
import 'package:flutter/material.dart';

import '../AppLocale.dart';

class DoneScreen extends StatefulWidget {
  const DoneScreen({super.key});

  @override
  State<DoneScreen> createState() => _DoneScreenState();
}

class _DoneScreenState extends State<DoneScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const NavBar(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/animationDone.gif',
              height: MediaQuery.of(context).size.height / 2.5,
              width: MediaQuery.of(context).size.width / 1.1,
            ),
            Text(
              AppLocale.of(context).translate('transComp')!,
              style: const TextStyle(fontSize: 15, fontFamily: 'poppins'),
            ),
          ],
        ),
      ),
    );
  }
}
