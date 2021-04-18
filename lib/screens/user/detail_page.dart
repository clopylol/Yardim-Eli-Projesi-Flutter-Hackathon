import 'package:flutter/material.dart';
import 'package:hackathon_project_v1/helpers/media_query_helper.dart';
import 'package:hackathon_project_v1/style/constants.dart';
import 'package:hackathon_project_v1/widgets/user_widgets/bottom_navigator_bar.dart';

class DetailPage extends StatefulWidget {
  final productImg;
  final productName;
  final productDescription;

  DetailPage(
      {Key key, this.productImg, this.productName, this.productDescription})
      : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  //Sepete eklenecek ürün sayısı
  int _productCount = 1;

  String _descriptionTitle = 'Ürün Açıklaması';

  //Ürün Sayısı Arttır
  void _productCounterUp() {
    //10'dan fazla ürün eklenmesin.
    _productCount < 10
        ? setState(() {
            _productCount++;
          })
        : null;
  }

  //Ürün Sayısı Azaltır
  void _productCounterDown() {
    //Ürün sayısı 1'den az olamaz.
    _productCount > 1
        ? setState(() {
            _productCount--;
          })
        : null;
  }

  //Tekrara düştük.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: kOrange,
      appBar: appBarWidget(),
      bottomNavigationBar: bottomNavigatorBarWidget(context, kOrange),
      floatingActionButton:
          floatingActionButtonWidget(context, Icons.add, "/null", kOrange),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: ListView(
        children: [
          Stack(
            children: [
              //Sayfa genişliği ve arkaplan rengi
              backgroundPageWidget(),

              //Ürün detaylarının içerisinde bulunduğu border radiuslu kart
              detailCardWidget(),

              //Ürün Resmi
              productImageWidget(),

              //Ürün Adı
              Positioned(
                top: 250,
                left: 25,
                right: 25,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //Ürün Adı
                    productNameWidget(widget.productName),

                    SizedBox(height: 20),

                    //Ürün Fiyat ve Adet
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //Ürün Ücretiz
                        productMoneyWidget(),

                        //Fiyat ve Adet Arasındaki Divider
                        productVerticalDividerWidget(),

                        //Ürün Adeti
                        productCountWidget()
                      ],
                    ),

                    SizedBox(height: 50),

                    //Ürün Açıklaması Başlığı ve Ürün Açıklaması
                    productDescriptionWidget(
                      descriptionTitle: _descriptionTitle,
                      description: widget.productDescription,
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  //App Bar
  Widget appBarWidget() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      // leading: IconButton(
      //   icon: IconButton(
      //     icon: Icon(Icons.arrow_back),
      //     color: Colors.white,
      //     onPressed: () {},
      //   ),
      //   onPressed: () {
      //     Navigator.pop(context);
      //   },
      // ),
      title: Text(
        'Ürün Detayı',
        style: TextStyle(
          fontFamily: 'Montserrat',
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(icon: Icon(Icons.more_horiz), onPressed: () {}),
      ],
    );
  }

  //Background pagesize - color
  Widget backgroundPageWidget() {
    return Container(
      height: displayHeight(context) * .9,
      width: displayWidth(context),
      color: kOrange,
    );
  }

  //Product Detail Card
  Widget detailCardWidget() {
    return Positioned(
      top: 75,
      child: Container(
        height: displayHeight(context) * .8,
        width: displayWidth(context),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(45),
            topRight: Radius.circular(45),
          ),
        ),
      ),
    );
  }

  //Detail Card'taki Ürün Resmi
  Widget productImageWidget() {
    return Positioned(
      top: 30,
      left: (displayWidth(context) / 2) - 200,
      right: (displayWidth(context) / 2) - 200,
      child: Hero(
        tag: widget.productImg,
        child: CircleAvatar(
          radius: displayHeight(context) * 0.153,
          backgroundColor: colorPrimary,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: displayHeight(context) * 0.15,
            backgroundImage: NetworkImage(widget.productImg),
          ),
        ),
      ),
    );
  }

  //Detail Card İçerisindeki Ürün Adı
  Widget productNameWidget(String productName) {
    return Text(
      productName,
      style: Theme.of(context).textTheme.headline4.copyWith(color: textColor),
    );
  }

  //Detail Card İçerisindeki Ürün Fiyatı
  Widget productMoneyWidget() {
    return Container(
      width: 125,
      height: 40,
      child: Center(
        child: Text(
          'Ücretsiz',
          style: Theme.of(context)
              .textTheme
              .headline4
              .copyWith(color: colorPrimary),
        ),
      ),
    );
  }

  //Fiyat ve Adet Arasındaki Dikey Divider
  Widget productVerticalDividerWidget() {
    return Padding(
      padding: EdgeInsets.only(right: 40, left: 40),
      child: Container(height: 30, color: kOrange, width: 3.0),
    );
  }

  //Ürün adet seçimi
  Widget productCountWidget() {
    return Container(
      width: 125,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        color: colorPrimary,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () => _productCounterDown(),
            child: Container(
              child: Center(
                child: Icon(
                  Icons.remove,
                  color: colorPrimary,
                  size: 20,
                ),
              ),
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7), color: Colors.white),
            ),
          ),
          Text(
            '$_productCount',
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: Colors.white),
          ),
          InkWell(
            onTap: () => _productCounterUp(),
            child: Container(
              child: Center(
                child: Icon(
                  Icons.add,
                  color: colorPrimary,
                  size: 20,
                ),
              ),
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7), color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  //Ürün Açıklama başlığı ve detay açıklaması
  Widget productDescriptionWidget(
      {String descriptionTitle, String description}) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: 15.0),
                child: Divider(
                  thickness: 3,
                  color: kOrange,
                ),
              ),
            ),
            Text(
              'Ürün Açıklaması',
              style: Theme.of(context).textTheme.headline6,
            ),
            Expanded(
              child: Container(
                  margin: EdgeInsets.only(left: 15.0),
                  child: Divider(
                    thickness: 3,
                    color: kOrange,
                    height: 50,
                  )),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('${widget.productDescription}'),
        ),
      ],
    );
  }
}
