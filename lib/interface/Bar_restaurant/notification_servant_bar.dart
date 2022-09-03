// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class NotificationServantBar extends StatelessWidget {
  const NotificationServantBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.greenAccent,
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.99,
    );
  }
}
