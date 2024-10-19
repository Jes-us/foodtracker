import 'package:flutter/material.dart';
import 'package:foodtracker/view/components/screen_size.dart';

import 'package:foodtracker/view/cupboard_screen/cupboard_screen.dart';
import 'package:foodtracker/view/constants.dart';

class OpenFoodFacts extends StatelessWidget {
  const OpenFoodFacts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: ksecondsDelay), () {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const HomePage();
      }));
      // productViewModel.dismisOpenFoodFacts();
    });

    double screenHeight = ScreenSizeProvider.of(context)?.screenHeight ?? 0;
    double screenWidth = ScreenSizeProvider.of(context)?.screenWidth ?? 0;
    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        color: Theme.of(context).colorScheme.onPrimary,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset(kfoodFactsLogo,
                  width: screenWidth * 0.5,
                  height: screenHeight * 0.05,
                  fit: BoxFit.contain),
              Text(kfoodFactsLabel,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 12)),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
