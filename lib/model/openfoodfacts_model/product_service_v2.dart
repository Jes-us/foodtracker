import 'package:foodtracker/model/api_status.dart';
import 'package:foodtracker/model/constants.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

class ProdructService {
  String upcNumber;
  ProdructService(this.upcNumber);

  Future<Object> getProductInfor() async {
    var barcode = upcNumber;

    // ignore: unused_local_variable
    final UserAgent apiConfiguration =
        OpenFoodAPIConfiguration.userAgent = UserAgent(name: kagent);

    final ProductQueryConfiguration configuration = ProductQueryConfiguration(
      barcode,
      language: OpenFoodFactsLanguage.ENGLISH,
      fields: [ProductField.ALL],
      version: ProductQueryVersion.v3,
    );
    try {
      final ProductResultV3 result =
          await OpenFoodAPIClient.getProductV3(configuration);

      if (ksuccess == result.status || ksuccesswwarnings == result.status) {
        int errorCode;

        if (result.product == null) {
          errorCode = 1;

          return Failure(errorCode: errorCode, errorResponse: kproductNotFound);
        } else {
          return Success(code: 0, response: result.product);
        }
      }

      if (ksuccess != result.status) {
        if ((result.result?.id ?? '') == kopenFoodFactsNotFoundId) {
          return Failure(errorCode: knotFound, errorResponse: kproductNotFound);
        } else if (result.status == kopenFoodFactsInvalidBarcode) {
          return Failure(errorCode: -2, errorResponse: kproductInvalidBarcode);
        } else if (result.status == kopenFoodFactsTooManyRequests) {
          return Failure(errorCode: -3, errorResponse: kproductTooManyRequests);
        } else if (result.status == kopenFoodFactsServerError) {
          return Failure(errorCode: -4, errorResponse: kproductServerError);
        } else {
          // Manejo de errores generales
          return Failure(errorCode: -1, errorResponse: result.status);
        }
      }
    } catch (e) {
      return Failure(errorCode: kundifines, errorResponse: e.toString());
    }

    return Failure(errorCode: 0, errorResponse: 'Unknown error');
  }
}
