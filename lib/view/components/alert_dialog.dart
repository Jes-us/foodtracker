import 'package:flutter/material.dart';
import 'package:foodtracker/core/app_export.dart';
import 'package:foodtracker/view/components/custom_text_button.dart';
import 'package:foodtracker/view/components/screen_size.dart';
import 'product_image.dart';
import 'package:foodtracker/view/constants.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    ProductViewModel productViewModel = context.read<ProductViewModel>();
    double dialogHeight = ScreenSizeProvider.of(context)?.screenHeight ?? 0.0;
    double dialogWidth = ScreenSizeProvider.of(context)?.screenWidth ?? 0.0;

    return Center(
      child: AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        key: const ValueKey(1),
        content: Container(
          height: dialogHeight * 0.40,
          width: dialogWidth * 0.50,
          color: Colors.transparent,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Flexible(
                  flex: 3,
                  child: FittedBox(
                    child: Text(kdeletionConfirm),
                  ),
                ),
                Spacer(),
                Container(
                  height: dialogHeight * 0.25,
                  width: dialogWidth * 0.45,
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  child: ProductImage(
                    imageUrl: productViewModel
                        .prodList[productViewModel.delIndex]['product']
                        .imageFrontUrl
                        .toString(),
                  ),
                ),
                Spacer(),
                Container(
                  padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45),
                    color: productViewModel.prodList[productViewModel.delIndex]
                                    ['daystoexpire']
                                .toString() ==
                            'Expired'
                        ? Theme.of(context).colorScheme.primary
                        : Colors.lightGreen,
                  ),
                  child: Text(
                    productViewModel.prodList[productViewModel.delIndex]
                            ['daystoexpire']
                        .toString(),
                    maxLines: 1,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ),
                Text(
                  productViewModel
                          .prodList[productViewModel.delIndex]['product'].brands
                          .toString()
                          .isEmpty
                      ? productViewModel
                          .prodList[productViewModel.delIndex]['product']
                          .productName
                          .toString()
                      : productViewModel
                          .prodList[productViewModel.delIndex]['product'].brands
                          .toString(),
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold),
                ),
              ]),
        ),
        actions: [
          SizedBox(
            width: dialogWidth * 0.90,
            child: CustomTextButton(
                label: kcancelButtonLabel,
                isFirst: false,
                isEnable: true,
                onPressed: () {
                  productViewModel.cancelDeletionDbProduct();
                }),
          ),
          SizedBox(
            width: dialogWidth * 0.90,
            child: CustomTextButton(
                label: kcontinueButtonLabel,
                isFirst: true,
                isEnable: true,
                onPressed: () async {
                  await productViewModel.confirmDeletionDbProduct();
                }),
          ),
        ],
      ),
    );
  }
}
