// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:projet/services/change_admin_page.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class FirtsBottomNavifgationAdminBar extends StatelessWidget {
  const FirtsBottomNavifgationAdminBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final changeProvider = Provider.of<changingAdminPage>(context);
    return BottomNavigationBar(
      backgroundColor: Colors.indigo.withOpacity(.8),
      onTap: (value) {
        changeProvider.currentIndex = value;
      },
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: Colors.white.withOpacity(.6),
          ),
          label: 'Accueil',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
            color: Colors.white.withOpacity(.6),
          ),
          label: 'Paramètres',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.meeting_room,
            color: Colors.white.withOpacity(.8),
          ),
          label: 'Réunin zoom',
        ),
      ],
      fixedColor: Colors.white,
    );
  }
}
