import 'package:flutter/material.dart';
import 'package:foodtracker/core/app_export.dart';

class CustomIconButton extends StatefulWidget {
  CustomIconButton(
      {super.key,
      this.shape,
      this.padding,
      this.variant,
      this.alignment,
      this.margin,
      this.width,
      this.height,
      this.child,
      this.onTap});

  IconButtonShape? shape;

  IconButtonPadding? padding;

  IconButtonVariant? variant;

  Alignment? alignment;

  EdgeInsetsGeometry? margin;

  double? width;

  double? height;

  Widget? child;

  VoidCallback? onTap;

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  @override
  Widget build(BuildContext context) {
    return widget.alignment != null
        ? Align(
            alignment: widget.alignment ?? Alignment.center,
            child: _buildIconButtonWidget(),
          )
        : _buildIconButtonWidget();
  }

  _buildIconButtonWidget() {
    return Padding(
      padding: widget.margin ?? EdgeInsets.zero,
      child: IconButton(
        visualDensity: const VisualDensity(
          vertical: -3,
          horizontal: -3,
        ),
        iconSize: getSize(widget.height ?? 0),
        padding: const EdgeInsets.all(0),
        icon: Container(
          alignment: Alignment.center,
          width: getSize(widget.width ?? 0),
          height: getSize(widget.height ?? 0),
          padding: _setPadding(),
          decoration: _buildDecoration(),
          child: widget.child,
        ),
        onPressed: widget.onTap,
      ),
    );
  }

  _buildDecoration() {
    return BoxDecoration(
      color: _setColor(),
      borderRadius: _setBorderRadius(),
    );
  }

  _setPadding() {
    switch (widget.padding) {
      default:
        return getPadding(
          all: 3,
        );
    }
  }

  _setColor() {
    switch (widget.variant) {
      default:
        return ColorConstant.blueA700;
    }
  }

  _setBorderRadius() {
    switch (widget.shape) {
      default:
        return BorderRadius.circular(
          getHorizontalSize(
            15.00,
          ),
        );
    }
  }
}

enum IconButtonShape {
  CircleBorder15,
}

enum IconButtonPadding {
  PaddingAll3,
}

enum IconButtonVariant {
  FillBlueA700,
}
