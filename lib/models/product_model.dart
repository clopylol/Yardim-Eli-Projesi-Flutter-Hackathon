class Product {
  String confirm;
  String description;
  String imageUrl;
  String name;
  String onSale;

  String key;

  Product(
      {this.confirm, this.description, this.imageUrl, this.name, this.onSale});

  Product.fromJson(Map<String, dynamic> json) {
    confirm = json["confirm"];
    description = json["description"];
    imageUrl = json["imageUrl"];
    name = json["name"];
    onSale = json["onSale"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['confirm'] = this.confirm;
    data['description'] = this.description;
    data['imageUrl'] = this.imageUrl;
    data['name'] = this.name;
    data['onSale'] = this.onSale;
    return data;
  }
}

//Dışardan Map alıp listeye atıyoruz.
class ProductList {
  List<Product> products = [];
  ProductList.fromJsonList(Map value) {
    value.forEach((key, value) {
      var product = Product.fromJson(value);
      product.key = key;
      products.add(product);
    });
  }
}
