import 'package:flutter/material.dart';
import 'package:foodtracker/core/app_export.dart';

class ProductCreation extends StatelessWidget {
  const ProductCreation({super.key});

  @override
  Widget build(BuildContext context) {
    ProductViewModel productViewModel = context.read<ProductViewModel>();

    final dynamic upcCode = productViewModel.upcNumber == ''
        ? 'not found'
        : productViewModel.upcNumber;

    double deviceDisplayheight = MediaQuery.of(context).size.height;
    double deviceDisplaywidth = MediaQuery.of(context).size.width;

    TextEditingController group10198TwoController = TextEditingController();
    TextEditingController group10199TwoController = TextEditingController();

    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Container(
      width: deviceDisplaywidth * 0.80,
      height: deviceDisplayheight * 0.80,
      margin: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 60.0),
      color: Theme.of(context).colorScheme.surface,
      child: Card(
        margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        color: Theme.of(context).colorScheme.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          side: BorderSide.none,
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Spacer(
                flex: 1,
              ),
              const Text('At this point the product does not exists'),
              Text(upcCode),
              const Spacer(
                flex: 2,
              ),
              Form(
                key: formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Product Name",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface)),
                      CustomTextFormField(
                          focusNode: FocusNode(),
                          controller: group10198TwoController,
                          hintText: "Enter Your Product Name",
                          margin: getMargin(top: 8),
                          textInputType: TextInputType.text),
                      Text(
                        'Brand',
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface),
                      ),
                      CustomTextFormField(
                        focusNode: FocusNode(),
                        controller: group10199TwoController,
                        hintText: "Enter the brand name",
                        margin: getMargin(top: 8),
                        textInputType: TextInputType.text,
                      ),
                      Center(
                          child: SizedBox(
                        height: 200.0,
                        width: 200.0,
                        child: InputImage(
                          fromCamera: false,
                        ),
                      )),
                      CustomElevatedButton(
                          tag: 'storeProduct',
                          onPress: () async {
                            try {
                              productViewModel.storeProductOpenFoodFacts(
                                  group10198TwoController.text);
                            } catch (e) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(CustomSnackBar.show(context));
                            }
                          },
                          label: 'Store a product'),
                    ]),
              ),
              const Spacer(
                flex: 3,
              ),
            ]),
      ),
    );
  }
}
