import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String imageUrl;

  const ProductImage({
    required this.imageUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        } else {
          return const CustomCircularProgressIndicator();
        }
      },
      errorBuilder: (context, error, stackTrace) {
        return const Icon(
          Icons.signal_wifi_connected_no_internet_4,
          size: 35,
          color: Color(0xFFF05833),
        );
      },
      fit: BoxFit.scaleDown,
    );
  }
}

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: const CircularProgressIndicator(
          color: Color(0xFfF05833),
          strokeWidth: 5,
        ),
      ),
    );
  }
}
