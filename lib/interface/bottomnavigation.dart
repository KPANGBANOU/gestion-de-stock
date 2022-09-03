// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:projet/services/change_page.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class bottomNavigation extends StatelessWidget {
  const bottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final changeProvider = Provider.of<changingPage>(context);
    return BottomNavigationBar(
      currentIndex: changeProvider.currentIndex,
      backgroundColor: Colors.green,
      type: BottomNavigationBarType.fixed,
      onTap: (value) {
        changeProvider.currentIndex = value;
      },
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: Colors.black,
          ),
          label: 'Accueil',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.account_circle_rounded,
            color: Colors.black,
          ),
          label: 'connexion',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.business,
            color: Colors.black,
          ),
          label: 'services',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.contact_phone,
            color: Colors.black,
          ),
          label: 'contacts',
        ),
      ],
      fixedColor: Colors.greenAccent,
    );
  }
}
