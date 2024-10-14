import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foodtracker/model/api_status.dart';
import 'package:foodtracker/model/openfoodfacts_model/product_model_v2.dart';
import 'package:foodtracker/model/user_error.dart';
import 'package:foodtracker/view_model/prodf_view_model.dart';
import 'package:foodtracker/model/openfoodfacts_model/product_service_v2.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

enum CupboardStattes { initial, loading, showcard, showalert, Error, Success }

class ProductViewModel extends ChangeNotifier {
  Product? _productModel;

  UserError _userError = UserError(code: 0, message: '');

  CupboardStattes _cupboardStattes = CupboardStattes.initial;

  ProdfProvider productsDB = ProdfProvider();

  bool _loading = false;
  bool _showcard = false;
  bool _showalert = false;
  bool _showError = false;
  bool _showSuccess = false;

  String _upcNumber = '';
  List<Map<String, dynamic>> _dbProduct = [];
  dynamic dbString;
  int _deletionId = 0;
  int _delIndex = 0;

  ProductViewModel() {
    getDataBaseProducts();
  }

  get productModel => _productModel;

  get userError {
    return _userError;
  }

  get loading => _loading;

  get showcard => _showcard;

  get showalert => _showalert;

  get showError => _showError;

  get showSuccess => _showSuccess;

  get upcNumber => _upcNumber;

  get prodList {
    return _dbProduct;
  }

  get delIndex => _delIndex;

  getToJson() {
    return jsonEncode(productModel.toJson());
  }

  setUpcNumber(String upcNumber) {
    _upcNumber = upcNumber;
    notifyListeners();
  }

  Future<void> getDataBaseProducts() async {
    _dbProduct = [];
    dynamic dbStrings = await productsDB.prodfList;

    dbStrings.forEach((element) {
      int index = dbStrings.indexOf(element);
      String daysToExpire;
      String jsonData = dbStrings[index].productmodel.toString();
      Product product = Product.fromJson(jsonDecode(jsonData));

      daysToExpire =
          getDateDiff(DateTime.parse(element.expirationdate)).toString();

      Map<String, dynamic> registro = {
        'id': element.id,
        'product': product,
        'expirationdate': element.expirationdate,
        'daystoexpire': daysToExpire
      };

      _dbProduct.add(registro);
    });
    notifyListeners();
  }

  String getDateDiff(DateTime expirationDate) {
    Duration difference;
    int daysToExpire;
    String labelVigencia = '';

    difference = expirationDate.difference(DateTime.now());
    daysToExpire = difference.inDays;

    if (daysToExpire < 0) {
      labelVigencia = 'Expired';
    } else {
      labelVigencia = 'Exp $daysToExpire days';
    }

    return labelVigencia;
  }

  //Stores a new product on the SQLlite instance
  storeProduct(String expirationDate) async {
    try {
      await productsDB.addProds(
          '', '', '', '', '', getToJson().toString(), expirationDate);
      getDataBaseProducts();
      setShowCard(false);

      _showSuccessDialog();
      notifyListeners();
    } catch (e) {
      print(e);
      //TODO definir manejo de errores
    }
  }

  cancelProdcutStorage() {
    setShowCard(false);
    notifyListeners();
  }

  deleteDbProduct(int id, int index) async {
    _showalert = true;
    _deletionId = id;
    _delIndex = index;
    notifyListeners();
  }

  confirmDeletionDbProduct() async {
    setLoading(true);
    await productsDB.deleteProds(_deletionId);
    _deletionId = 0;
    _showalert = false;

    UserError userError = UserError(code: 0, message: 'Record deleted');
    setUserError(userError);
    getDataBaseProducts();
    setLoading(false);
  }

  cancelDeletionDbProduct() async {
    _deletionId = 0;

    _showalert = false;
    notifyListeners();
  }

  _showErrorDialog() {
    _showError = true;
    notifyListeners();
  }

  _showSuccessDialog() {
    _showSuccess = true;
    notifyListeners();
  }

  dismissErrorDialog() {
    _showError = false;
    notifyListeners();
  }

  dismissSuccessDialog() {
    _showSuccess = false;
    notifyListeners();
  }

  productViewModel() {
    getProducts();
    notifyListeners();
  }

  setProductListModel(productListModel) {
    _productModel = productListModel;
    notifyListeners();
  }

  setUserError(UserError userError) {
    _userError = userError;
    notifyListeners();
  }

  setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  setShowCard(bool showcard) {
    _showcard = showcard;
    // notifyListeners();
  }

  cleanProductViewModel() {
    _productModel = ProductModel();
    notifyListeners();
  }

  getProducts() async {
    // setLoading(true); TODO desbloquear despues de la prueba de fotografia
    setLoading(true);
    await cleanProductViewModel();
    var response = await ProdructService(_upcNumber).getProductInfor();

    if (response is Success) {
      setShowCard(true);
      setLoading(false);
      setProductListModel(response.response);
      UserError userError = UserError(code: 0, message: '');
      setUserError(userError);

      notifyListeners();
    }
    if (response is Failure) {
      UserError userError =
          UserError(code: response.errorCode, message: response.errorResponse);

      setUserError(userError);
      setLoading(false);
      _showErrorDialog();

      notifyListeners();
    }
  }
}
