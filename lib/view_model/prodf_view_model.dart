import 'package:foodtracker/model/db_model/prodf_model.dart';
import 'package:foodtracker/model/db_model/db_helper.dart';

class ProdfProvider {
  List<Prodf> _prodfList = [];

  get prodfList async {
    //if (_prodfList.isEmpty) {
    await listProdfs();
    //  }
    return _prodfList;
  }

  Future<void> addProds(
      String upc,
      String brand,
      String image,
      String description,
      String tittle,
      String productmodel,
      String expirationdate) async {
    Prodf prodf = Prodf(
        upc: upc,
        brand: brand,
        image: image,
        description: description,
        tittle: tittle,
        productmodel: productmodel,
        expirationdate: expirationdate);
    await Databasehelper.instance.insert(prodf);

    listProdfs();
  }

  Future<void> deleteProds(int? id) async {
    await Databasehelper.instance.delete(id);

    listProdfs();
  }

  Future<void> listProdfs() async {
    _prodfList = await Databasehelper.instance.queryAllRows();

    // notifyListeners();
  }
}
