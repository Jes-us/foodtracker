import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Function()? onPressed;
  final bool isFirst;
  final bool isEnable;

  const CustomTextButton({
    super.key,
    required this.label,
    this.icon,
    required this.onPressed,
    required this.isFirst,
    required this.isEnable,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isEnable ? false : true,
      child: Opacity(
        opacity: isEnable ? 1.0 : 0.5,
        child: TextButton.icon(
          style: TextButton.styleFrom(
            backgroundColor: isFirst
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondary,
          ),
          icon: Icon(
            icon,
            color: isFirst
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onPrimary,
            size: 16.0,
          ),
          onPressed: onPressed,
          label: Text(
            label,
            style: TextStyle(
              color: isFirst
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
