import 'package:flutter/material.dart';
import 'package:hackathon_project_v1/models/product_model.dart';
import 'package:hackathon_project_v1/services/api_service.dart';
import 'package:hackathon_project_v1/style/constants.dart';

class DonatorAddProductPage extends StatefulWidget {
  DonatorAddProductPage({Key key}) : super(key: key);

  @override
  _DonatorAddProductPageState createState() => _DonatorAddProductPageState();
}

class _DonatorAddProductPageState extends State<DonatorAddProductPage> {
  //Form Validasyonu için bir global keye ihtiyacimiz var.
  GlobalKey<FormState> _formKey = GlobalKey(debugLabel: "formKey");

  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerImageUrl = TextEditingController();
  TextEditingController controllerDescription = TextEditingController();

  //TextEdittingControllerdaki String'in boş olup olmadığını kontrol için kullandık.
  String validatorStr(val) {
    if (val.isEmpty) {
      return 'Lütfen bu alanı boş bırakmayın !';
    }
    return null;
  }

  //TextEdittingController'ın boş olup olmadığını ve sayi olup olmadığını kontrol için kullandık.
  String validatorInt(val) {
    if (val.isEmpty) {
      return "Lütfen geçerli bir fiyat girin !";
    } else if (double.tryParse(val) == null) {
      return "Lütfen geçerli bir fiyat girin !";
    }
    return null;
  }

  //Servisimize datalarımızı gönderelim.
  dynamic postAddProduct() async {
    var model = Product(
        name: controllerName.text,
        imageUrl: controllerImageUrl.text,
        description: controllerDescription.text,
        onSale: "true");
    await ApiService.getInstance()
        .addProducts(model)
        .then((value) => clearTextController());
  }

  //Datları gönderdikten sonra text controller'ları temizleyelim
  void clearTextController() {
    controllerName.clear();
    controllerImageUrl.clear();
    controllerDescription.clear();
  }

  //Kullanıcı ürünü eklemek istediğe dair bir onay al.
  //Bunu dinamik bir hale getirip widget olarak ekle.
  //Text buttonu da dinamik yap..
  //Style felan filan bunları da dinamik yap.
  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Ürün Eklensin Mi ?"),
          content: RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.black, fontSize: 18),
              children: [
                TextSpan(
                    text: '${controllerName.text}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: colorPrimary)),
                TextSpan(text: ' adlı ürün,'),
                TextSpan(
                    text: ' Ücretsiz ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: colorPrimary)),
                TextSpan(text: 'olarak bağışlansın mı ?'),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                "İptal",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: colorPrimary),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "Bağışla",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: colorPrimary),
              ),
              onPressed: () {
                postAddProduct();
                Navigator.of(context).pop();
                _showAlert(
                    'Ürün Başarıyla Bağışlandı !', 'Tamam', Colors.green);
              },
            ),
          ],
        );
      },
    );
  }

  //Ürünün Eklendiğine Dair Kullanıcıya bir bilgi verelim.
  _showAlert(String alertTxt, String alertButtonTxt, Color alertColor) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: alertColor,
        content: Text('$alertTxt'),
        duration: Duration(seconds: 2),
        action: SnackBarAction(
          label: '$alertButtonTxt',
          textColor: kWhite,
          onPressed: () {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        title: Text('Bağış Yapılacak Ürün'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add_shopping_cart,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {});
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: colorSecondary,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(
                    'https://avatars.githubusercontent.com/u/37087597?v=4'),
                //Login Eklenince burayı dinamik yaparız.
              ),
            ),
          ),
        ],
      ),
      //bottomNavigationBar: bottomNavigatorBarWidget(context),
      // floatingActionButton:
      //     floatingActionButtonWidget(context, Icons.shopping_cart_rounded, ""),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  textFormWidget(
                    controller: controllerName,
                    validator: this.validatorStr,
                    inputIcon: Icons.assignment_rounded,
                    inputText: 'Ürün Adı',
                  ),

                  textFormWidget(
                    controller: controllerImageUrl,
                    validator: this.validatorStr,
                    inputIcon: Icons.add_a_photo,
                    inputText: 'Ürün Resmi',
                  ),
                  textFormWidget(
                    controller: controllerDescription,
                    validator: this.validatorStr,
                    inputIcon: Icons.description,
                    inputText: 'Ürün Açıklaması',
                  ),

                  //Kaydet Buttonu
                  saveButtonWidget(buttonName: 'ÜRÜN KAYDET'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

//  Kalıp Text Form Field
  Widget textFormWidget(
      {dynamic controller,
      dynamic validator,
      IconData inputIcon,
      String inputText,
      TextInputType keyboardType}) {
    return Column(
      children: [
        TextFormField(
          cursorColor: colorPrimary,
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          decoration: inputDecoration(inputIcon, inputText),
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 10))
      ],
    );
  }

  //Kalıp Input Decoration
  InputDecoration inputDecoration(IconData inputIcon, String inputText) {
    return InputDecoration(
      //prefixIcon: Icon(inputIcon),
      suffixIcon: Icon(inputIcon),
      //icon: Icon(inputIcon),
      border: OutlineInputBorder(),
      labelText: inputText,
      //hasFloatingPlaceholder: true,
      //şeylerde sıkıntı var validate
    );
  }

  //Ürünü Kaydet buttonu
  Widget saveButtonWidget({@required String buttonName}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            height: 56,
            child: ElevatedButton(
              onPressed: _showDialog,
              child: Text('$buttonName'),
              style: ElevatedButton.styleFrom(
                primary: colorPrimary,
                textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
