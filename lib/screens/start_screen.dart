import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/screens/start/address_page.dart';
import 'package:untitled1/screens/start/auth_page.dart';
import 'package:untitled1/screens/start/intro_page.dart';

class StartScreen extends StatelessWidget {
  StartScreen({Key? key}) : super(key: key);

  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider<PageController>.value(
      value: _pageController,
      child: Scaffold(
        body: PageView(controller: _pageController,
            // physics: NeverScrollableScrollPhysics(),
            children: [IntroPage(_pageController), AddressPage(), AuthPage()]),
      ),
    );
  }
}
