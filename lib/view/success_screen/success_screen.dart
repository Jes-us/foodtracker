import 'package:flutter/material.dart';
import 'package:foodtracker/view/components/screen_size.dart';
import 'package:foodtracker/core/app_export.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ProductViewModel productViewModel = context.read<ProductViewModel>();
    Future.delayed(const Duration(seconds: 3), () {
      productViewModel.dismissSuccessDialog();
    });

    double screenHeight = ScreenSizeProvider.of(context)?.screenHeight ?? 0;
    double screenWidth = ScreenSizeProvider.of(context)?.screenWidth ?? 0;
    return Container(
      width: screenWidth,
      height: screenHeight,
      color: Theme.of(context).colorScheme.surface,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Icon(Icons.check_circle,
                size: screenHeight * 0.1,
                color: Theme.of(context).colorScheme.primary),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Text(productViewModel.successMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16)),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
