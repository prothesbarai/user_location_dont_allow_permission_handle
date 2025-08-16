import 'package:flutter/material.dart';

class OverlayUpdateHive {
  static bool _isShowing = false;

  static void show(BuildContext context, String text) {
    if (_isShowing) return;
    _isShowing = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 15),
                    Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Hide the overlay
  static void hide(BuildContext context) {
    if (_isShowing) {
      _isShowing = false;
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

}
