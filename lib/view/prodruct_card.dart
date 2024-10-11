import 'package:flutter/material.dart';
import 'package:foodtracker/core/app_export.dart';

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

    double deviceDisplayheight = MediaQuery.of(context).size.height;
    double deviceDisplaywidth = MediaQuery.of(context).size.width;

    final ktextStyle2 =
        TextStyle(color: Theme.of(context).colorScheme.onSurface);

    final ktextStyle1 = TextStyle(
      fontWeight: FontWeight.bold,
      color: Theme.of(context).colorScheme.onSurface,
    );

    return Container(
      width: deviceDisplaywidth * 0.80,
      height: deviceDisplayheight * 0.80,
      // padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 60.0),
      color: Theme.of(context).colorScheme.surface,
      child: Card(
        margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        color: Theme.of(context).colorScheme.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          side: BorderSide.none,
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Spacer(),
              Expanded(
                flex: 3,
                child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(
                        flex: 1,
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          padding: const EdgeInsets.all(5),
                          iconSize: 20.0,
                          alignment: Alignment.topCenter,
                          style: Theme.of(context).filledButtonTheme.style,
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            productViewModel.cancelProdcutStorage();
                          },
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: FittedBox(
                          child: Text(
                            brand,
                            textAlign: TextAlign.left,
                            style: ktextStyle1,
                          ),
                        ),
                      ),
                      const Spacer(
                        flex: 2,
                      )
                    ]),
              ),
              const Spacer(),
              Expanded(
                flex: 30,
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
              Flexible(
                flex: 1,
                child: FittedBox(
                  child: Text(
                    upcCode,
                    textAlign: TextAlign.left,
                    style: ktextStyle2,
                  ),
                ),
              ),
              const Spacer(),
              Flexible(
                flex: 2,
                child: FittedBox(
                  child: Text(
                    title,
                    textAlign: TextAlign.left,
                    style: ktextStyle1,
                  ),
                ),
              ),
              const Spacer(),
              Expanded(
                flex: 10,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Text(
                    description,
                    style: ktextStyle2,
                  ),
                ),
              ),
              const Spacer(),
              Expanded(
                flex: 3,
                child: Center(
                  child: SizedBox(
                    width: deviceDisplaywidth * 0.50,
                    child: CustomElevatedButton(
                      tag: 'pickDate',
                      onPress: () async {
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
                      label: 'Save',
                    ),
                  ),
                ),
              ),
              const Spacer()
            ]),
      ),
    );
  }
}

/* class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.productViewModel,
  });

  final ProductViewModel productViewModel;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: Theme.of(context).filledButtonTheme.style,
        child: Text(
          'Guardar',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimary),
        ),
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
        });
  }
} */
