import 'dart:convert';
import 'dart:io';
import 'package:hackathon_project_v1/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

/*
Singleton sınıflardan nesneler, sınıf üzerinden bir kere oluşturulur ve
sonraki işlemlerde bu nesne üzerinden devam edilir.
Lazy load kullanarak ekranda sadece olan nesnelerin görselleri gelsin,
performans kaybı yaşamayalım.
*/

class ApiService {
  String _baseUrl;
  static ApiService _instance = ApiService._privateConstructer();

  //Bu sınıftan başka bir instance oluşturulmaması için private yaptık.
  ApiService._privateConstructer() {
    _baseUrl =
        "https://hackathon-project-47fbe-default-rtdb.europe-west1.firebasedatabase.app/";
  }

  static ApiService getInstance() {
    if (_instance == null) {
      return ApiService._privateConstructer();
    }
    return _instance;
  }

  //Firebase'te tuttuğumuz verileri çekelim.
  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse("$_baseUrl/products.json"));
    final jsonResponse = json.decode(response.body);
    switch (response.statusCode) {
      //Hata oluşmazsa. Bize map dönecek list değil, buna dikkat !
      case HttpStatus.ok: //İstek başarılıysa
        final productList = ProductList.fromJsonList(jsonResponse);
        return productList.products;

      //Buradaki caseleri çoğaltabiliriz. EKLE !
      //Herhangi bir hata olursa logger ile yazdıralım.
      case HttpStatus.unauthorized:
        Logger().e(jsonResponse);
        break;
    }
    Logger().e(jsonResponse);
    return Future.error(jsonResponse);
  }

  //Firebase'e ürün ekle.
  Future<void> addProducts(Product product) async {
    //Post isteği atalım
    final jsonBody = json.encode(product.toJson());
    final response =
        await http.post(Uri.parse("$_baseUrl/products.json"), body: jsonBody);

    final jsonResponse = json.decode(response.body);

    switch (response.statusCode) {
      //Hata oluşmazsa. Bize map dönecek buna dikkat
      case HttpStatus.ok:
        print('Ürün Başarıyla EKLENDİ !');
        return Future.value(true);

      //Herhangi bir hata olursa
      case HttpStatus.unauthorized:
        Logger().e(jsonResponse);
        break;
    }
    Logger().e(jsonResponse);
    return Future.error(jsonResponse);
  }

  //Firebase'ten ürün sil
  Future<void> removeProducts(String key) async {
    // final response = await http
    //     .delete("$_baseUrl/products/$key.json");

    // final jsonResponse = json.decode(response.body);
    // switch (response.statusCode) {
    //   case HttpStatus.ok:
    //     return Future.value(true);

    //   case HttpStatus.unauthorized:
    //     Logger().e(jsonResponse);
    //     break;
    // }
    // Logger().e(jsonResponse);
    // return Future.error(jsonResponse);
  }
}
