import 'package:flutter/material.dart';

class CustomFormFieldWidget extends StatefulWidget {
  CustomFormFieldWidget(
      {super.key,
      required this.group10198Controller,
      required this.hintText,
      required this.obscureTextisOn,
      this.validationMessage});

  final TextEditingController group10198Controller;
  String hintText;
  bool obscureTextisOn;
  String? validationMessage; //Function(String?)? validator;

  @override
  State<CustomFormFieldWidget> createState() => _CustomFormFieldWidgetState();
}

class _CustomFormFieldWidgetState extends State<CustomFormFieldWidget> {
  bool obscureText = true;
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.group10198Controller.hashCode,
      child: TextFormField(
        focusNode: _focusNode,
        enableSuggestions: true,
        controller: widget.group10198Controller,
        obscureText: widget.obscureTextisOn ? obscureText : false,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.onSurface, width: 0.5),
            ),
            filled: true,
            fillColor: Theme.of(context).colorScheme.surface,
            hintText: widget.hintText,
            hintStyle:
                TextStyle(color: Theme.of(context).colorScheme.onSurface),
            suffixIconColor: Theme.of(context).colorScheme.onSurface,
            suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    if (obscureText) {
                      obscureText = false;
                    } else {
                      obscureText = true;
                    }
                  });
                },
                icon: Visibility(
                  visible: widget.obscureTextisOn,
                  child: Icon(
                    obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ))),
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return widget.validationMessage ?? 'Please enter some text';
          }
          return null;
        },
      ),
    );
  }
}
