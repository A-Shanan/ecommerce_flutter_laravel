// ignore_for_file: avoid_print, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:ecommerce_flutter_laravel/AppLocale.dart';
import 'package:ecommerce_flutter_laravel/providers/language_provider.dart';
import 'package:ecommerce_flutter_laravel/providers/theme_provider.dart';
import 'package:ecommerce_flutter_laravel/screens/done_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Testt extends StatelessWidget {
  const Testt({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocale.of(context).translate('home')!),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: Provider.of<ThemeProvider>(context).linearGradient,
        ),
        child: ListView(
          children: [
            TextButton(
                onPressed: () async {
                  await Provider.of<LanguageProvider>(context, listen: false)
                      .changeLanguage('en');
                },
                child: Text('english')),
            TextButton(
                onPressed: () async {
                  await Provider.of<LanguageProvider>(context, listen: false)
                      .changeLanguage('ar');
                },
                child: Text('arabic')),
            TextButton(
                onPressed: () async {
                  await Provider.of<ThemeProvider>(context, listen: false)
                      .changeTheme('light');
                },
                child: Text('light')),
            TextButton(
                onPressed: () async {
                  await Provider.of<ThemeProvider>(context, listen: false)
                      .changeTheme('dark');
                },
                child: Text('dark')),
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DoneScreen(),
                    ),
                  );
                },
                icon: Icon(Icons.ad_units)),
            const SizedBox(
              height: 100,
            ),
            Align(
              widthFactor: 0.5,
              child: Container(
                width: MediaQuery.of(context).size.width / 2.2,
                height: MediaQuery.of(context).size.height / 3.5,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Colors.amber,
                ),
                child: Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          child: Image.network(
                            'https://img.freepik.com/free-photo/close-up-bird-with-word-owl-it_1340-28794.jpg?w=2000',
                            fit: BoxFit.fitWidth,
                            width: MediaQuery.of(context).size.width / 1.5,
                            height: MediaQuery.of(context).size.height / 6,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 9, right: 9, top: 5, bottom: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('title'),
                              const Text(
                                  'discriptionasdsdsadsadsadsadasdasdasda'),
                              const Text('price'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0, right: 12.0),
                      child: Container(
                        height: 32.0,
                        width: 32.0,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            onPressed: () {
                              print('favIcon is pressed');
                            },
                            icon: const Icon(
                              Icons.favorite_border,
                              color: Colors.red,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
