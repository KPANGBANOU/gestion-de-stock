// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:flutter/foundation.dart';

class changbierreid extends ChangeNotifier {
  String _current_id = "Fanta";

  String get currentIdBieere => _current_id;

  set currentId(String id) {
    _current_id = id;
    notifyListeners();
  }
}
