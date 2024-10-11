import 'package:flutter/material.dart';
//import 'package:foodtracker/core/app_export.dart';

class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton(
      {super.key,
      required this.onPress,
      required this.label,
      required this.tag});

  void Function() onPress;
  String label;
  String tag;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: ElevatedButton(
        key: key,
        style: Theme.of(context).filledButtonTheme.style,
        onPressed: onPress,
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
