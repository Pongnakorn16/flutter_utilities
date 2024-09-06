import 'package:flutter/material.dart';

class AppData with ChangeNotifier {
  //Shared data
  String email = '';
  late UserProfile user;
}

class UserProfile {
  int idx = 0;
  String username = '';
  String fullname = '';
}
