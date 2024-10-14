import 'package:flutter/material.dart';
import 'package:foodtracker/core/app_export.dart';
import 'package:foodtracker/view/components/card_text.dart';
import 'package:foodtracker/view/components/product_image.dart';

import 'animated_card.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ProductViewModel productViewModel = context.watch<ProductViewModel>();

    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 3.0,
          mainAxisSpacing: 3.0,
        ),
        itemCount: productViewModel.prodList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onLongPress: () async {
              await productViewModel.deleteDbProduct(
                  productViewModel.prodList[index]['id'], index);
            },
            child: Container(
              color: Theme.of(context).colorScheme.surface,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Card in the list
                    Expanded(
                      flex: 4,
                      child: FittedBox(
                        child: AnimatedCard(
                          front: Card(
                              color: Theme.of(context).colorScheme.onPrimary,
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                child: ProductImage(
                                    imageUrl: productViewModel
                                        .prodList[index]['product']
                                        .imageFrontUrl
                                        .toString()),
                              )),
                          back: Card(
                            color: Theme.of(context).colorScheme.secondary,
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child: Center(
                              child: CardText(
                                text: productViewModel.prodList[index]
                                        ['expirationdate']
                                    .toString(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    //End Card in the grid
                    Flexible(
                      flex: 1,
                      child: Row(children: [
                        const Spacer(
                          flex: 1,
                        ),
                        Expanded(
                          flex: 6,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(45),
                              color: productViewModel.prodList[index]
                                              ['daystoexpire']
                                          .toString() ==
                                      'Expired'
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.lightGreen,
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Spacer(
                                    flex: 1,
                                  ),
                                  Flexible(
                                    flex: 6,
                                    child: FittedBox(
                                      child: Text(
                                        productViewModel.prodList[index]
                                                ['daystoexpire']
                                            .toString(),
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary),
                                      ),
                                    ),
                                  ),
                                  const Spacer(
                                    flex: 1,
                                  ),
                                ]),
                          ),
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                      ]),
                    ),
                    Flexible(
                      flex: 1,
                      child: FittedBox(
                        child: Text(
                          productViewModel.prodList[index]['product'].brands
                                  .toString()
                                  .isEmpty
                              ? productViewModel
                                  .prodList[index]['product'].productName
                                  .toString()
                              : productViewModel
                                  .prodList[index]['product'].brands
                                  .toString(),
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ]),
            ),
          );
        });
  }
}
