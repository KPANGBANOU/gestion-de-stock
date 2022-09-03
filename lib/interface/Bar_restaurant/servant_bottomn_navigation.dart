// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:projet/services/change_servant_page.dart';

import 'package:provider/provider.dart';

// ignore: camel_case_types
class ServantbottomNavigation extends StatelessWidget {
  const ServantbottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final changeProvider = Provider.of<changingServantPage>(context);
    return BottomNavigationBar(
      currentIndex: changeProvider.currentIndex,
      backgroundColor: Colors.indigo.withOpacity(.8),
      type: BottomNavigationBarType.fixed,
      onTap: (value) {
        changeProvider.currentIndex = value;
      },
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: Colors.white,
          ),
          label: 'Accueil',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.notification_important,
            color: Colors.white,
          ),
          label: 'Notification',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.contact_phone_rounded,
            color: Colors.white,
          ),
          label: 'Contacts',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.business_rounded,
            color: Colors.white,
          ),
          label: 'Services',
        ),
      ],
      fixedColor: Colors.greenAccent,
    );
  }
}
