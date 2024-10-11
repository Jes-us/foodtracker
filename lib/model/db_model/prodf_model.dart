import 'dart:convert';

Prodf prodfFromJson(String str) => Prodf.fromJson(json.decode(str));

String prodfToJson(Prodf data) => json.encode(data.toJson());

class Prodf {
  int? id;
  String upc;
  String brand;
  String image;
  String description;
  String tittle;
  String productmodel;
  String expirationdate;

  Prodf(
      {this.id,
      required this.upc,
      required this.brand,
      required this.image,
      required this.description,
      required this.tittle,
      required this.productmodel,
      required this.expirationdate});

  factory Prodf.fromJson(Map<String, dynamic> json) => Prodf(
      id: json["id"],
      upc: json["upc"],
      brand: json["brand"],
      image: json["image"],
      description: json["description"],
      tittle: json["tittle"],
      productmodel: json["productmodel"],
      expirationdate: json["expirationdate"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "upc": upc,
        "brand": brand,
        "image": image,
        "description": description,
        "tittle": tittle,
        "productmodel": productmodel,
        "expirationdate": expirationdate
      };
}
