import 'package:flutter/material.dart';
import 'package:foodtracker/view/components/prodruct_card.dart';
import 'package:foodtracker/view/components/loading_app.dart';
import 'package:foodtracker/view/cupboard_screen/error_screen.dart';
import 'package:foodtracker/view/cupboard_screen/success_screen.dart';
import '../components/product_list.dart';
import '../components/alert_dialog.dart';
import '../components/animated_transitions.dart';
import 'package:foodtracker/core/app_export.dart';
import 'package:barcode_scan2/barcode_scan2.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String scanBarcode = '-1';

  @override
  void initState() {
    super.initState();
  }

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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(15), // Radio de la parte inferior
                ),
              ),
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
                    fontSize: 16,
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
                    Icons.photo_camera,
                    size: 30.0,
                    weight: 20.0,
                    color: Color.fromARGB(255, 249, 243, 243),
                  ),
                  onPressed: () async {
                    await _scan();

                    if (scanBarcode != '-1' && scanBarcode != "") {
                      await productViewModel.setUpcNumber(scanBarcode);
                      await productViewModel.getProducts();
                    }
                  }),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
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
        productViewModel.showalert == false &&
        productViewModel.showSuccess == false &&
        productViewModel.showError == false) {
      return true;
    } else {
      return false;
    }
  }

  Widget currentWidget(
      BuildContext context, ProductViewModel productViewModel) {
    if (productViewModel.loading == false &&
        productViewModel.showcard == false &&
        productViewModel.showError == false &&
        productViewModel.showSuccess == false &&
        productViewModel.showalert == false) {
      return CustomAnimatedTransition(aniteWidget: ProductList());
    }
    if (productViewModel.loading == false &&
        productViewModel.showcard == true &&
        productViewModel.showError == false &&
        productViewModel.showSuccess == false &&
        productViewModel.showalert == false) {
      return CustomAnimatedTransition(aniteWidget: ProductCard());
    }
    if (productViewModel.loading == false &&
        productViewModel.showcard == false &&
        productViewModel.showError == false &&
        productViewModel.showSuccess == false &&
        productViewModel.showalert == true) {
      return CustomAnimatedTransition(aniteWidget: CustomAlertDialog());
    }

    if (productViewModel.loading == false &&
        productViewModel.showcard == false &&
        productViewModel.showalert == false &&
        productViewModel.showSuccess == false &&
        productViewModel.showError == true) {
      return CustomAnimatedTransition(aniteWidget: ErrorScreen());
    }

    if (productViewModel.loading == false &&
        productViewModel.showcard == false &&
        productViewModel.showalert == false &&
        productViewModel.showError == false &&
        productViewModel.showSuccess == true) {
      return CustomAnimatedTransition(
          aniteWidget: SuccessScreen(
        message: 'Product stored correctly',
      ));
    }
    return const LoadingApp();
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
