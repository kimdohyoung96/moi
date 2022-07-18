import 'package:untitled1/components/appBarWithBack.dart';
import 'package:untitled1/screens/start/styles.dart';
import 'package:flutter/material.dart';

class TermsPage extends StatelessWidget {
  final String title;
  final String type;
  const TermsPage({Key? key, required this.title, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarWithBack(title),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
              Image.asset(
                'assets/imgs/terms_' + type + '.jpg',
              )
            ])));
  }
}