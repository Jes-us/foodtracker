import 'package:flutter/material.dart';

class CustomBoxTittle extends StatelessWidget {
  CustomBoxTittle({super.key, required this.descriptionText});

  String descriptionText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Text(descriptionText,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: 15.0, color: Theme.of(context).colorScheme.onSurface)),
    );
  }
}
