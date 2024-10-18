import 'package:flutter/material.dart';
import 'package:foodtracker/view/components/google_ads.dart';
import 'package:foodtracker/view/components/prodruct_card.dart';
import 'package:foodtracker/view/components/loading_app.dart';
import 'package:foodtracker/view/components/screen_size.dart';
import 'package:foodtracker/view/error_screen/error_screen.dart';
import 'package:foodtracker/view/success_screen/success_screen.dart';
import 'package:foodtracker/view_model/internet_connection_view_model.dart';
import '../components/product_list.dart';
import '../components/alert_dialog.dart';
import '../components/animated_transitions.dart';
import 'package:foodtracker/core/app_export.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
//Tutorial Import
import 'package:foodtracker/view/components/onboarding_tutorial.dart';
import 'package:foodtracker/view_model/shared_preferences_services.dart';
import 'package:foodtracker/view/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TutorialService tutorialService = TutorialService();

  GlobalKey themeChanger = GlobalKey();
  GlobalKey scannerButton = GlobalKey();
  GlobalKey productCard = GlobalKey();
  late OnboardingTutorial onboardingTutorial;
  String scanBarcode = '-1';

  @override
  void initState() {
    onboardingTutorial = OnboardingTutorial(
      context: context,
      themeChanger: themeChanger,
      scannerButton: scannerButton,
    );

    tutorialService.isTutorialShown().then((value) {
      if (!value) {
        onboardingTutorial.createTutorial();
        Future.delayed(Duration.zero, onboardingTutorial.showTutorial);
        tutorialService.setTutorialShown(true);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProductViewModel productViewModel = context.watch<ProductViewModel>();
    ConnectivityModel internetConnection = context.watch<ConnectivityModel>();
    double screenHeight = ScreenSizeProvider.of(context)?.screenHeight ?? 0.0;
    double screenWidth = ScreenSizeProvider.of(context)?.screenWidth ?? 0.0;

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
                    key: themeChanger,
                    icon: CustomAnimatedIcon(change: themeNotifier.actualTheme),
                    onPressed: () {
                      themeNotifier.changeTheme(ThemeMode.dark);
                      change = true;
                    },
                  ),
                ],
                title:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Container(
                    height: screenWidth * 0.07,
                    width: screenWidth * 0.07,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(kbarImage),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Text(
                    key: productCard,
                    kappBarTittle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: kappBarTittleFont,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color:
                            Theme.of(context).colorScheme.onPrimaryContainer),
                  ),
                ]),
              ),
              body: SizedBox.expand(
                child: Stack(
                  children: [
                    currentWidget(context, productViewModel),
                    Positioned(
                      bottom: 25.0,
                      left: 50.0,
                      child: Visibility(
                        visible: internetConnection.connectionStatus ==
                            knoConnectionLabel,
                        child: Container(
                          height: screenHeight * 0.05,
                          width: screenWidth * 0.70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Icon(
                                    Icons.wifi_off,
                                    size: 20,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Flexible(
                                  child: Text(
                                    knoConnectionLabel,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              floatingActionButton: Visibility(
                visible: showfloatingActionButton(
                    productViewModel, internetConnection),
                child: FloatingActionButton(
                    key: scannerButton,
                    heroTag: kheroFloatingBtn,
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
                      //scanBarcode = '051500243312'; //jiff
                      //scanBarcode = '021000619849'; //queso philadelphia
                      //scanBarcode = '021000619849'; //queso philadelphia

                      if (scanBarcode != kscanError && scanBarcode != "") {
                        await productViewModel.setUpcNumber(scanBarcode);
                        await productViewModel.getProducts();
                      }
                    }),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,

              //  ],
              // ),
              bottomNavigationBar: GoogleAdsBanner()),
        );
      },
    );
  }

  bool showfloatingActionButton(
      ProductViewModel productViewModel, ConnectivityModel intenetConnection) {
    if (productViewModel.loading == false &&
        productViewModel.showcard == false &&
        productViewModel.showalert == false &&
        productViewModel.showSuccess == false &&
        productViewModel.showError == false &&
        intenetConnection.connectionStatus != 'No Connection') {
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
      return CustomAnimatedTransition(aniteWidget: SuccessScreen());
    }
    return const LoadingApp();
  }

  Future<void> _scan() async {
    try {
      final result = await BarcodeScanner.scan(
        options: ScanOptions(
          strings: {
            'cancel': kscanCancelLabel,
            'flash_on': kflashOnLabel,
            'flash_off': kflashOffLabel,
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
      scanBarcode = kscanError;
    }
  }
}
