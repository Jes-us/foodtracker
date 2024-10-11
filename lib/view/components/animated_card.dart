import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedCard extends StatefulWidget {
  Widget front;
  Widget back;

  AnimatedCard({required this.front, required this.back, super.key});

  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFront = true;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _flipCard() {
    if (_controller.status != AnimationStatus.forward) {
      if (_isFront) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
      _isFront = !_isFront;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flipCard,
      child: Center(
        child: SizedBox(
          width: 180,
          height: 180,
          child: Transform(
            transform: Matrix4.rotationY(_animation.value * math.pi),
            alignment: Alignment.center,
            child: _isFront ? _buildFront() : _buildBack(),
          ),
        ),
      ),
    );
  }

  Widget _buildFront() {
    return widget.front;
  }

  Widget _buildBack() {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(3.14),
      child: widget.back,
    );
  }
}
