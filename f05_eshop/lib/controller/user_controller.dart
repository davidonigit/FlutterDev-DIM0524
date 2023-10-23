import 'package:flutter/foundation.dart';

class UserController with ChangeNotifier {
  String userId = '';

  void setUserId(String id) {
    userId = id;
    notifyListeners();
  }
}
