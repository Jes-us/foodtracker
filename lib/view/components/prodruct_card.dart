import 'package:flutter/material.dart';
import 'package:foodtracker/core/app_export.dart';
import 'package:foodtracker/view/components/custom_text_button.dart';
import 'package:foodtracker/view/components/screen_size.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    ProductViewModel productViewModel = context.read<ProductViewModel>();

    String upcCode = productViewModel.productModel.barcode == ''
        ? 'not found'
        : productViewModel.productModel.barcode;

    String image;
    if (productViewModel.productModel.imageFrontUrl != null) {
      image = productViewModel.productModel.imageFrontUrl;
    } else {
      image = 'not found';
    }

    String brand = productViewModel.productModel.brands ?? 'not found';
    String description =
        productViewModel.productModel.ingredientsText ?? 'not found';
    String title =
        'not found'; //productViewModel.productModel.genericName.toString();

    double deviceDisplayheight =
        ScreenSizeProvider.of(context)?.screenHeight ?? 0;
    double deviceDisplaywidth =
        ScreenSizeProvider.of(context)?.screenWidth ?? 0;

    final ktextStyle2 =
        TextStyle(color: Theme.of(context).colorScheme.onSurface);

    final ktextStyle1 = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: Theme.of(context).colorScheme.onSurface,
    );

    return Container(
      width: deviceDisplaywidth,
      height: deviceDisplayheight,
      color: Theme.of(context).colorScheme.surface,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Spacer(),
            Align(
              alignment: Alignment.center,
              child: Text(
                brand,
                textAlign: TextAlign.left,
                style: ktextStyle1,
              ),
            ),
            const Spacer(),
            Container(
              width: deviceDisplaywidth * 0.85,
              height: deviceDisplayheight * 0.50,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.network(
                image,
                errorBuilder: (context, error, stackTrace) =>
                    const Text('error'),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 5,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Text(
                  description,
                  style: ktextStyle2,
                ),
              ),
            ),
            SizedBox(
              width: deviceDisplaywidth * 0.90,
              child: CustomTextButton(
                label: 'Store Product',
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                    builder: (context, child) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [FittedBox(child: child)],
                      );
                    },
                    context: context,
                    initialDate: DateTime.now(), //get today's date
                    firstDate: DateTime(
                        2000), //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2101),
                  );

                  if (pickedDate != null) {
                    String date = '$pickedDate';
                    await productViewModel.storeProduct(date);
                  }
                },
                isFirst: true,
                isEnable: true,
              ),
            ),
            SizedBox(
              width: deviceDisplaywidth * 0.90,
              child: CustomTextButton(
                label: 'Back',
                onPressed: () {
                  productViewModel.cancelProdcutStorage();
                },
                isFirst: false,
                isEnable: true,
              ),
            ),
            const Spacer(),
          ]),
    );
  }
}
