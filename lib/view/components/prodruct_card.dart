import 'package:flutter/material.dart';
import 'package:foodtracker/core/app_export.dart';
import 'package:foodtracker/view/components/custom_text_button.dart';
import 'package:foodtracker/view/components/loading_app.dart';
import 'package:foodtracker/view/components/screen_size.dart';
import 'package:foodtracker/view/constants.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    ProductViewModel productViewModel = context.read<ProductViewModel>();

    String image;
    if (productViewModel.productModel.imageFrontUrl != null) {
      image = productViewModel.productModel.imageFrontUrl;
    } else {
      image = '';
    }

    String brand = productViewModel.productModel.brands ?? kbrandNotFound;
    String description =
        productViewModel.productModel.ingredientsText ?? kingredientsNotFoound;

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
      color: Theme.of(context).colorScheme.secondary,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                brand,
                textAlign: TextAlign.center,
                style: ktextStyle1,
              ),
            ),
            const Spacer(),
            Container(
              width: deviceDisplaywidth * 0.60,
              height: deviceDisplayheight * 0.30,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.network(
                image,
                errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.photo_album,
                    color: Theme.of(context).colorScheme.onSurface),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(child: LoadingApp());
                  }
                },
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 6,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    '$kingredients $description',
                    textAlign: TextAlign.center,
                    style: ktextStyle2,
                  ),
                ),
              ),
            ),
            Spacer(),
            SizedBox(
              width: deviceDisplaywidth * 0.90,
              child: CustomTextButton(
                label: kbackButton,
                onPressed: () {
                  productViewModel.cancelProdcutStorage();
                },
                isFirst: false,
                isEnable: true,
              ),
            ),
            SizedBox(
              width: deviceDisplaywidth * 0.90,
              child: CustomTextButton(
                label: kstoreProductButton,
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                    initialEntryMode: DatePickerEntryMode.calendarOnly,
                    initialDatePickerMode: DatePickerMode.year,

                    builder: (context, child) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [FittedBox(child: child)],
                      );
                    },
                    context: context,
                    initialDate: DateTime.now(), //get today's date
                    firstDate: DateTime
                        .now(), //DateTime.now() - not to allow to choose before today.
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
            const Spacer(),
          ]),
    );
  }
}
