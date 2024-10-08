import 'dart:io';

import 'package:bfaf_submisi_restaurant_app/navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

customDialog(BuildContext context) {
  if (Platform.isIOS) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Coming Soon'),
          content: const Text('This feature is coming soon!'),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () {
                Navigation.back();
              },
            ),
          ],
        );
      },
    );
  } else {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Coming Soon'),
          content: const Text('This feature is coming soon!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigation.back();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}