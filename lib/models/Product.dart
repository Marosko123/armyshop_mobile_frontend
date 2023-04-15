class Product {
  int? id;
  String? name;
  double? price;
  String? description;
  String? imageUrl;
  String? subcategoryId;
  bool? licenseNeeded;

  Product.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'];
    name = map['name'];
    price = map['price'];
    description = map['description'];
    imageUrl = map['image_url'];
    subcategoryId = map['subcategory_id'];
    licenseNeeded = map['license_needed'] == 1;
  }
}
