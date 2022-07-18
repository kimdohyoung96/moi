import 'package:untitled1/screens/start/styles.dart';
import 'package:flutter/material.dart';

AppBar appBarWithBack(text) {
  return AppBar(
      shape: Border(bottom: BorderSide(color: gray07, width: 1)),
      backgroundColor: white,
      foregroundColor: gray01,
      elevation: 0.1,
      title: Text(
        text,
        style: body2Bold,
      ));
}