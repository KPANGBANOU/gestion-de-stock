import 'package:flutter/material.dart';

// ignore: camel_case_types
class bottomNavigationHome extends StatelessWidget {
  const bottomNavigationHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.green,
      onTap: (value) {},
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.contact_phone,
            color: Colors.black,
          ),
          label: 'Mes Contacts',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.notifications,
            color: Colors.black,
          ),
          label: 'Notifications',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.info,
            color: Colors.black,
          ),
          label: 'Info',
        ),
      ],
      fixedColor: Colors.white,
    );
  }
}
