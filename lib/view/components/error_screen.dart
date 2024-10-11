import 'package:flutter/material.dart';
import 'package:foodtracker/view/components/custom_text_button.dart';
import 'package:foodtracker/view/components/screen_size.dart';
import 'package:foodtracker/core/app_export.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ProductViewModel productViewModel = context.read<ProductViewModel>();
    double screenHeight = ScreenSizeProvider.of(context)?.screenHeight ?? 0;
    double screenWidth = ScreenSizeProvider.of(context)?.screenWidth ?? 0;
    return Container(
      width: screenWidth,
      height: screenHeight,
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Icon(Icons.error,
                size: screenHeight * 0.1,
                color: Theme.of(context).colorScheme.onSecondary),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Text('Product is not registered at Open Food Facts',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondary,
                    fontSize: 16)),
            Spacer(),
            SizedBox(
              width: screenHeight * 0.6,
              child: CustomTextButton(
                label: 'Continue',
                isFirst: true,
                isEnable: true,
                onPressed: () {
                  productViewModel.dismissErrorDialog();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
