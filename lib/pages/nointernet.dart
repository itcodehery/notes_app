import 'package:flutter/material.dart';
import 'package:notes_app/theme.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.signal_wifi_off_outlined,
              size: 100,
              color: AppTheme.colorTheme.primaryColor,
            ),
            const SizedBox(height: 16),
            const Text(
              'No Internet Connection',
              style: TextStyle(
                fontFamily: 'Jost',
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 10),
            const SizedBox(
              width: 300,
              child: Text(
                'Please check your internet connection and try again.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontFamily: 'Jost',
                ),
              ),
            ),
            const SizedBox(height: 40),
            const SizedBox(
              width: 300,
              child: Text(
                'If you have internet, close and reopen this app.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontFamily: 'Jost',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
