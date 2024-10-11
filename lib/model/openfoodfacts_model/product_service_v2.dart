import 'package:foodtracker/model/api_status.dart';
import 'package:foodtracker/constants.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

class ProdructService {
  String upcNumber;
  ProdructService(this.upcNumber);

  Future<Object> getProductInfor() async {
    var barcode = upcNumber;

    final UserAgent apiConfiguration =
        OpenFoodAPIConfiguration.userAgent = UserAgent(name: 'FoodTracker');

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
        String? errorMessage;

        if (result.product == null) {
          errorCode = 1;
          errorMessage = result.status;

          return Failure(errorCode: errorCode, errorResponse: errorMessage);
        } else {
          return Success(code: 0, response: result.product);
        }
      }

      if (ksuccess != result.status) {
        return Failure(errorCode: -1, errorResponse: result.status);
      }
    } catch (e) {
      return Failure(errorCode: kundifines, errorResponse: e.toString());
    }

    return Failure(errorCode: 0, errorResponse: 'Unknown error');
  }
}
