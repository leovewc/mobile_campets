import 'package:flutter/material.dart';
import '../constants.dart';

void showConfirmationDialog(
    BuildContext context,
    String title,
    String content,
    VoidCallback onConfirm,
    ) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(
          child:  Text(
            title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
            color: kTextColor,
          ),
        ),
        ),
        content: Text(
          content,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: kTextColor,
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: kPrimaryColor,fontWeight: FontWeight.w600,)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onConfirm();
            },
            child: const Text("Confirm", style: TextStyle(color: kPrimaryColor,fontWeight: FontWeight.w600,)),
          ),
        ],
      );
    },
  );
}
