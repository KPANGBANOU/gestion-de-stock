import 'package:flutter/material.dart';

// ignore: camel_case_types
class FirstBottomNavigation extends StatelessWidget {
  const FirstBottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.green,
      onTap: (value) {},
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.account_circle_rounded,
            color: Colors.black,
          ),
          label: 'Suivi',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.business,
            color: Colors.black,
          ),
          label: 'Produits',
        ),
       
      ],
      fixedColor: Colors.white,
    );
  }
}
