import 'package:flutter/material.dart';
import 'package:foodtracker/view/prodruct_card.dart';
import 'package:foodtracker/utilities/barcode_reader.dart';
import 'package:foodtracker/view/components/loading_app.dart';
import '../components/product_list.dart';
import '../components/alert_dialog.dart';
import '../components/animated_transitions.dart';
import 'package:foodtracker/core/app_export.dart';
import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:barcode_scan2/barcode_scan2.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  String scanBarcode = '-1';

  @override
  Widget build(BuildContext context) {
    ProductViewModel productViewModel = context.watch<ProductViewModel>();

    scanBarcode = '-1';

    bool change = false;

    return Consumer<Manage>(
      builder: (context, Manage themeNotifier, child) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            appBar: AppBar(
              elevation: 1,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              actions: [
                IconButton(
                  icon: CustomAnimatedIcon(change: themeNotifier.actualTheme),
                  onPressed: () {
                    themeNotifier.changeTheme(ThemeMode.dark);
                    change = true;
                  },
                ),
              ],
              title: Text(
                'Food Tracker',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Abril Fatface',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimaryContainer),
              ),
            ),

            body: SizedBox.expand(
              child: currentWidget(context, productViewModel),
            ),

            floatingActionButton: Visibility(
              visible: showfloatingActionButton(productViewModel),
              child: FloatingActionButton(
                  heroTag: 'btn1',
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: const Icon(
                    Icons.add,
                    size: 30.0,
                    weight: 20.0,
                    color: Color.fromARGB(255, 249, 243, 243),
                  ),
                  onPressed: () async {
                    await _scan();

                    if (scanBarcode != '-1') {
                      await productViewModel.setUpcNumber(scanBarcode);
                      await productViewModel.getProducts();

                      if (productViewModel.userError.code != 0 &&
                          productViewModel.showSnackbar == true) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(CustomSnackBar.show(context));
                      }
                    }
                  }),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            //  ],
            // ),
          ),
        );
      },
    );
  }

  bool showfloatingActionButton(ProductViewModel productViewModel) {
    if (productViewModel.loading == false &&
        productViewModel.showcard == false &&
        productViewModel.productCreation == false &&
        productViewModel.showalert == false &&
        productViewModel.takeaPicture == false &&
        productViewModel.userError.code == 0) {
      return true;
    } else {
      return false;
    }
  }

  Widget currentWidget(
      BuildContext context, ProductViewModel productViewModel) {
    if (productViewModel.loading == false &&
        productViewModel.showcard == false &&
        productViewModel.productCreation == false &&
        productViewModel.showalert == false &&
        productViewModel.takeaPicture == false) {
      return CustomAnimatedTransition(aniteWidget: const ProductList());
    }
    if (productViewModel.loading == false &&
        productViewModel.showcard == true &&
        productViewModel.productCreation == false &&
        productViewModel.showalert == false &&
        productViewModel.takeaPicture == false) {
      return CustomAnimatedTransition(aniteWidget: const ProductCard());
    }
    if (productViewModel.loading == false &&
        productViewModel.showcard == false &&
        productViewModel.productCreation == false &&
        productViewModel.showalert == true &&
        productViewModel.takeaPicture == false) {
      return CustomAnimatedTransition(aniteWidget: const CustomAlertDialog());
    }
    if (productViewModel.loading == false &&
        productViewModel.showcard == false &&
        productViewModel.productCreation == true &&
        productViewModel.showalert == false &&
        productViewModel.takeaPicture == false) {
      return CustomAnimatedTransition(aniteWidget: const ProductCreation());
    }
    if (productViewModel.loading == false &&
        productViewModel.showcard == false &&
        productViewModel.productCreation == false &&
        productViewModel.showalert == false &&
        productViewModel.takeaPicture == true) {
      return CustomAnimatedTransition(
          aniteWidget: InputImage(
        fromCamera: false,
      ));
    } else {
      return const LoadingApp();
    }
  }

  Future<void> _scan() async {
    try {
      final result = await BarcodeScanner.scan(
        options: ScanOptions(
          strings: {
            'cancel': 'cancel',
            'flash_on': 'flash_on',
            'flash_off': 'flash_off'
          },
          useCamera: -1,
          autoEnableFlash: false,
          android: AndroidOptions(
            aspectTolerance: 0.5,
            useAutoFocus: true,
          ),
        ),
      );
      scanBarcode = result.rawContent.toString();
    } catch (e) {
      scanBarcode = '-1';
    }
  }
}

class BarCodeScanner extends StatelessWidget {
  const BarCodeScanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AiBarcodeScanner(
      fit: BoxFit.scaleDown,
      onDispose: () {
        /// This is called when the barcode scanner is disposed.
        /// You can write your own logic here.
        debugPrint("Barcode scanner disposed!");
      },
      hideGalleryButton: false,
      controller: MobileScannerController(
        detectionSpeed: DetectionSpeed.noDuplicates,
      ),
      onDetect: (BarcodeCapture capture) {
        /// The row string scanned barcode value
        // final String? scannedValue =
        String _scanBarcode = capture.barcodes.first.rawValue ?? '-1';
        debugPrint("Barcode scanned: $_scanBarcode");

        /// row data of the barcode
        final Object? raw = capture.raw;
        debugPrint("Barcode raw: $raw");

        /// List of scanned barcodes if any
        final List<Barcode> barcodes = capture.barcodes;
        debugPrint("Barcode list: $barcodes");
      },
      validator: (value) {
        if (value.barcodes.isEmpty) {
          return false;
        }
        if (!(value.barcodes.first.rawValue?.contains('flutter.dev') ??
            false)) {
          return false;
        }
        return true;
      },
    );
  }
}
