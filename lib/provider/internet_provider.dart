import 'package:flutter/cupertino.dart';

class InternetConnectivity extends ChangeNotifier {
  bool _isInternet = false;

  bool get isInternet => _isInternet;

  Future<void> checkInternet() async {
    // Implement your internet check logic here
    await Future.delayed(const Duration(seconds: 2)); // Simulate a check
    _isInternet = true; // Update the state
    notifyListeners();
  }
}
