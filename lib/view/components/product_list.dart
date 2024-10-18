import 'dart:math';
import 'package:flutter/material.dart';
import 'package:foodtracker/core/app_export.dart';
import 'package:foodtracker/view/components/card_text.dart';
import 'package:foodtracker/view/components/product_image.dart';
import 'animated_card.dart';
import 'empty_product.dart';
import 'package:foodtracker/view/constants.dart';

class ProductList extends StatelessWidget {
  ProductList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ProductViewModel productViewModel = context.watch<ProductViewModel>();

    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: productViewModel.prodList.isEmpty ||
                productViewModel.prodList.length < kdefaultProducts
            ? kdefaultProducts
            : productViewModel.prodList.length + kextraProducts,
        itemBuilder: (BuildContext context, int index) {
          // Generar un margen aleatorio para desordenar la disposición
          final random = Random();
          final offset = random.nextInt(30) - 15.0; // Aleatorio entre -15 y +15

          if (productViewModel.prodList.isEmpty) {
            return EmptyProductWidget(offset: offset);
          } else {
            if (index >= productViewModel.prodList.length) {
              return EmptyProductWidget(offset: offset);
            } else {
              return Transform.translate(
                offset: Offset(offset, offset),
                child: GestureDetector(
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
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
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
                                  color:
                                      Theme.of(context).colorScheme.secondary,
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
                                            kexpiredLabel
                                        ? Theme.of(context).colorScheme.primary
                                        : Colors.lightGreen,
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                productViewModel.prodList[index]['product']
                                        .brands.isEmpty
                                    ? 'Brand not available'
                                    : productViewModel
                                                .prodList[index]['product']
                                                .brands
                                                .toString()
                                                .length >=
                                            10
                                        ? productViewModel
                                            .prodList[index]['product'].brands
                                            .toString()
                                            .substring(0, 10)
                                        : productViewModel
                                            .prodList[index]['product'].brands
                                            .toString(),
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
              );
            }
          }
        });
  }
}
