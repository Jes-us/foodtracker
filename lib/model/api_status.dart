import 'package:openfoodfacts/openfoodfacts.dart';

class Success {
  int code;
  Product? response;

  Success({required this.code, required this.response});
}

class Failure {
  int errorCode;
  String? errorResponse;
  Failure({required this.errorCode, required this.errorResponse});
}
