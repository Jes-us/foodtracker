//import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class BarCode {
  String scanBarcode = '';

  Future<String> scanBarcodeNormal() async {
    try {
      // scanBarcode = await FlutterBarcodeScanner.scanBarcode(
      //    '#FFFFFF', 'Cancel', false, ScanMode.BARCODE);

      // _scanBarcode = barcodeScanRes;
      return scanBarcode;
    } catch (e) {
      return scanBarcode = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
  }

  Future<String> getBarCode() async {
    scanBarcodeNormal();
    String barCode = scanBarcode;
    return barCode;
  }
}
