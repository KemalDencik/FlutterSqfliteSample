class Product {
  int? id;
  String? name;
  String? description;
  double? unitPrice;

  Product({this.description, this.name, this.unitPrice});

  Product.withId({this.id, this.description, this.name, this.unitPrice});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    if (id != null) {
      map["id"] = id;
    }
    map["name"] = name;
    map["description"] = description;
    map["unitPrice"] = unitPrice;
    return map;
  }

  factory Product.fromObject(dynamic object) {
    return Product.withId(
      id: object["id"],
      name: object["name"],
      description: object["description"],
      unitPrice: double.tryParse(object["unitPrice"].toString()),
    );
  }
}
