// ignore_for_file: camel_case_types, prefer_final_fields

import 'package:flutter/foundation.dart';

class changingPage with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
