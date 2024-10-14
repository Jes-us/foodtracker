import 'package:flutter/material.dart';

class CustomAnimatedIcon extends StatefulWidget {
  const CustomAnimatedIcon({super.key, required this.change});

  final ThemeMode change;

  @override
  State<CustomAnimatedIcon> createState() => _CustomAnimatedIconState();
}

class _CustomAnimatedIconState extends State<CustomAnimatedIcon> {
  bool icon = true;

  @override
  Widget build(BuildContext context) {
    if (widget.change == ThemeMode.dark) {
      icon = true;
    } else {
      icon = false;
    }
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      transitionBuilder: (child, animation) {
        return RotationTransition(
          turns: Tween(begin: 0.5, end: 25.0).animate(animation),
          child: child,
        );
      },
      child: Icon(
        icon ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
        key: ValueKey(widget.change),
        color: icon
            ? Theme.of(context).colorScheme.onPrimary
            : Theme.of(context).colorScheme.onSecondary,
        size: 20,
      ),
    );
  }
}
