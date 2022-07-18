import 'package:flutter/material.dart';

Widget arrowIcon() {
  return Image.asset(
    'assets/images/ic_right_arrow.png',
    fit: BoxFit.cover,
    height: 24.0,
    width: 24.0,
  );
}

Widget modifyIcon() {
  return Image.asset(
    'assets/images/ic_modify.png',
    fit: BoxFit.cover,
    height: 24.0,
    width: 24.0,
  );
}

Image iconImageSmall(name, size) {
  return Image.asset(
    'assets/images/ic_' + name + '.png',
    fit: BoxFit.cover,
    height: size,
    width: size,
  );
}