import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class SnackBarServices {
  static void showSuccessMessage(
    String message, {
    bool isLoginWarning = false,
  }) {
    BotToast.showCustomNotification(
      duration: Duration(seconds: 10),

      toastBuilder: (void Function() cancelFunction) {
        return Material(
          color: Colors.transparent,
          child: Container(
            margin: EdgeInsets.all(12),
            padding: EdgeInsets.all(12),
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(child: Text(message, textAlign: TextAlign.start)),
                IconButton(
                  onPressed: () { cancelFunction.call();},
                  icon: Icon(Icons.clear, size: 24),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void showWarningMessage(
    String message, {
    bool isLoginWarning = false,
  }) {
    BotToast.showCustomNotification(
      duration: Duration(seconds: 10),

      toastBuilder: (void Function() cancelFunction) {
        return Material(
          color: Colors.transparent,
          child: Container(
            margin: EdgeInsets.all(12),
            padding: EdgeInsets.all(12),
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.yellowAccent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
             crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(child: Text(message, textAlign: TextAlign.start)),
                IconButton(
                  onPressed: () { cancelFunction.call();},
                  icon: Icon(Icons.clear, size: 24),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void showErrorMessage(String message, {
    bool isLoginWarning = false}) {
    BotToast.showCustomNotification(
      duration: Duration(seconds: 10),

      toastBuilder: (void Function() cancelFunction) {
        return Material(
          color: Colors.transparent,
          child: Container(
            margin: EdgeInsets.all(12),
            padding: EdgeInsets.all(12),
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(child: Text(message, textAlign: TextAlign.start)),
                IconButton(
                  onPressed: () { cancelFunction.call();},
                  icon: Icon(Icons.clear, size: 24),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
