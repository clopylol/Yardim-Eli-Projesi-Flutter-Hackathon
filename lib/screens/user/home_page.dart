import 'package:flutter/material.dart';
import 'package:hackathon_project_v1/helpers/media_query_helper.dart';
import 'package:hackathon_project_v1/models/product_model.dart';
import 'package:hackathon_project_v1/screens/user/detail_page.dart';
import 'package:hackathon_project_v1/services/api_service.dart';
import 'package:hackathon_project_v1/style/constants.dart';
import 'package:hackathon_project_v1/widgets/user_widgets/bottom_navigator_bar.dart';
import 'package:hackathon_project_v1/widgets/user_widgets/home_app_bar_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //ApiServisten verileri alalım
  ApiService service = ApiService.getInstance();

  //Servisten gelen dataları bu listte tutacağız.
  List<Product> productList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: kOrange,
      bottomNavigationBar: bottomNavigatorBarWidget(context, kOrange),
      floatingActionButton: floatingActionButtonWidget(
          context, Icons.shopping_cart_rounded, "", kOrange),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: Column(
        children: [
          homeAppBarWidget(context),

          SizedBox(height: 10),

          //Ürün Sayfasının başlığı
          bodyTitleWidget(
              mainTitle: 'Ücretsiz',
              subTitle: 'Ürünler'), //Yukarıya al bunları.

          SizedBox(height: 40),

          //Ürünlerin Bulduğu Kart
          _bodyContainerWidget(dataWidget: showDataBuilder()),
        ],
      ),
    );
  }

  //Body Başlık
  Widget bodyTitleWidget({String mainTitle, subTitle}) {
    return Padding(
      padding: EdgeInsets.only(left: 40),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: mainTitle,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kWhite,
                    fontSize: 28,
                  ),
                ),
                TextSpan(
                  text: " $subTitle",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: kWhite,
                    fontSize: 28,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //Ürünlerin listelendiği kart
  Widget _bodyContainerWidget({@required Widget dataWidget}) {
    return Container(
      padding: EdgeInsets.only(left: 25, right: 20, top: 11),
      height: displayHeight(context) * 0.75,
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
      ),
      child: dataWidget, //showDataBuilder()
    );
  }

  //Ürün Kalıp Tasarım Widgetı
  Widget _buildProductItem(
      {String productDescription,
      String productImg,
      String productName,
      String productOnSale}) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 5),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DetailPage(
                productImg: productImg,
                productName: productName,
                productDescription: productDescription,
              ),
            ),
          );
        }, //NAVİGATE EKLENECEK
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: [
                  Hero(
                    tag: productImg,
                    child: Image(
                        //Local datadan resim göstermek istersek => AssetImage(productImg),
                        image: NetworkImage(productImg),
                        fit: BoxFit.cover,
                        height: 90,
                        width: 90),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productName,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 24.0,
                          color: textColor,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Ücretsiz',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: colorPrimary),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.add,
                size: 32,
              ),
              color: colorPrimary,
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }

  //Ürün Kalıplarını kullanarak gelen tüm dataları listele
  Widget _listProduct() {
    return ListView.builder(
        itemCount: productList.length,
        itemBuilder: (context, index) {
          return _buildProductItem(
              productImg: productList[index].imageUrl,
              productName: productList[index].name,
              productDescription: productList[index].description);
        });
  }

  //Ürünleri Göster
  Widget showDataBuilder() {
    return FutureBuilder<List<Product>>(
      future: service.getProducts(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          //Diğer case durumları da eklenecek !
          case ConnectionState.done:
            if (snapshot.hasData) {
              productList = snapshot.data;
              return _listProduct();
            }
            return Center(child: Text("Bir Hata Meydana Geldi !"));
          default:
            return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
