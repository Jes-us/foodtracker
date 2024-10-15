import 'package:flutter/material.dart';

class LoadingApp extends StatelessWidget {
  const LoadingApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: const CircularProgressIndicator(
          color: Color(0xFFF05833),
          strokeWidth: 5,
        ),
      ),
    );
  }
}
