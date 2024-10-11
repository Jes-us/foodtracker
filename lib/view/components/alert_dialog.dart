import 'package:flutter/material.dart';
import 'package:foodtracker/core/app_export.dart';
import 'product_image.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    ProductViewModel productViewModel = context.read<ProductViewModel>();

    return Center(
      child: AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        key: const ValueKey(1),
        content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Flexible(
                  flex: 3,
                  child: FittedBox(
                      child: Text('Are you sure to delete this item?'))),
              Flexible(
                flex: 1,
                child: Center(
                  child: Row(children: [
                    const Spacer(flex: 1),
                    Expanded(
                      flex: 7,
                      child: Card(
                          margin: const EdgeInsets.all(5),
                          color: Theme.of(context).colorScheme.surface,
                          semanticContainer: false,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          child: ProductImage(
                            imageUrl: productViewModel
                                .prodList[productViewModel.delIndex]['product']
                                .imageFrontUrl
                                .toString(),
                          )),
                    ),
                    Column(mainAxisSize: MainAxisSize.min, children: [
                      Flexible(
                        fit: FlexFit.loose,
                        flex: 1,
                        child: Container(
                          padding:
                              const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(45),
                            color: productViewModel
                                        .prodList[productViewModel.delIndex]
                                            ['daystoexpire']
                                        .toString() ==
                                    'Expired'
                                ? Theme.of(context).colorScheme.primary
                                : Colors.lightGreen,
                          ),
                          child: FittedBox(
                            child: Text(
                              productViewModel
                                  .prodList[productViewModel.delIndex]
                                      ['daystoexpire']
                                  .toString(),
                              maxLines: 1,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        flex: 1,
                        child: Text(
                          productViewModel
                              .prodList[productViewModel.delIndex]['product']
                              .brands
                              .toString(),
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ]),
                    const Spacer(flex: 1)
                  ]),
                ),
              ),
            ]),
        actions: [
          TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                productViewModel.cancelDeletionDbProduct();
              }),
          TextButton(
              child: const Text(
                'Continue',
                style: TextStyle(color: Colors.lightGreen),
              ),
              onPressed: () async {
                await productViewModel.confirmDeletionDbProduct();
              }),
        ],
      ),
    );
  }
}
