import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodtracker/model/api_status.dart';
import 'package:foodtracker/model/openfoodfacts_model/product_model_v2.dart';
import 'package:foodtracker/model/user_error.dart';
import 'package:foodtracker/view_model/prodf_view_model.dart';
import 'package:foodtracker/model/openfoodfacts_model/product_service_v2.dart';
import 'package:http/http.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

class ProductViewModel extends ChangeNotifier {
  Product? _productModel;
  UserError _userError = UserError(code: 0, message: '');
  ProdfProvider productsDB = ProdfProvider();
  bool _loading = false;
  bool _showcard = false;
  bool _showalert = false;
  bool _showSnackbar = false;
  bool _showProductCreation = false;
  bool _takeaPicture = false;
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
    //setSnackbar(false);
    return _userError;
  }

  get loading => _loading;

  get showcard => _showcard;

  get takeaPicture => _takeaPicture;

  get showalert => _showalert;

  get productCreation => _showProductCreation;

  get upcNumber => _upcNumber;

  get prodList {
    return _dbProduct;
  }

  get delIndex => _delIndex;

  get showSnackbar => _showSnackbar;

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
      notifyListeners();
    } catch (e) {
      print(e);
      //TODO definir manejo de errores
    }
  }

  _setTakeaPicture(bool takeaPicture) {
    _takeaPicture = takeaPicture;
  }

  // Stores a new product a the firestore DB
  storeProductOpenFoodFacts(String description) {
    Response response = ProdructService(_upcNumber).addNewProduct(description);

    if (response is Success) {
      // setShowCard(true);

      _setTakeaPicture(true);
      setProductListModel(response.body);
      UserError userError = UserError(code: 0, message: '');
      setUserError(userError);

      notifyListeners();
    }
    if (response is Failure) {
      UserError userError =
          UserError(code: response.statusCode, message: response.body);

      setUserError(userError);
      setSnackbar(true);
      setLoading(false);

      notifyListeners();
    }
    _setProductCreation(false);
    notifyListeners();
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
    await productsDB.deleteProds(_deletionId);
    _deletionId = 0;
    _showalert = false;

    UserError userError = UserError(code: 0, message: 'Record deleted');
    setUserError(userError);
    setSnackbar(true);
    getDataBaseProducts();
    notifyListeners();
  }

  cancelDeletionDbProduct() async {
    _deletionId = 0;
    _showalert = false;
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
    notifyListeners();
  }

  setSnackbar(bool showsnack) {
    _showSnackbar = showsnack;
    notifyListeners();
  }

  _setProductCreation(bool productCreation) {
    _showProductCreation = productCreation;
  }

  cleanProductViewModel() {
    _productModel = ProductModel();
    notifyListeners();
  }

  getProducts() async {
    // setLoading(true); TODO desbloquear despues de la prueba de fotografia
    await cleanProductViewModel();
    var response = await ProdructService(_upcNumber).getProductInfor();

    if (response is Success) {
      setShowCard(true);
      setProductListModel(response.response);
      UserError userError = UserError(code: 0, message: '');
      setUserError(userError);
      setLoading(false);
      notifyListeners();
    }
    if (response is Failure) {
/*       UserError userError =
          UserError(code: response.errorCode, message: response.errorResponse);

      setUserError(userError);
      _setProductCreation(true);
      setLoading(false); */

      notifyListeners();
    }
  }
}
