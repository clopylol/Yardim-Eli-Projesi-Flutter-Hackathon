import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_project_v1/screens/admin/admin_page.dart';
import 'package:hackathon_project_v1/screens/admin/admin_show_product.dart';
import 'package:hackathon_project_v1/screens/donater_user/donator_add_product.dart';
import 'package:hackathon_project_v1/screens/donater_user/donator_page.dart';
import 'package:hackathon_project_v1/screens/login/login_screen.dart';
import 'package:hackathon_project_v1/screens/user/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      debugShowCheckedModeBanner: false,
      //home: UserManagement().handleAuth(),

      routes: {
        '/': (context) => LoginScreen(), //Geçerli Sayfa
        '/adminPage': (context) => AdminPage(),
        '/adminShowProduct': (context) => AdminShowProduct(),
        '/userPage': (context) => HomePage(),
        '/donatorPage': (context) => DonatorPage(),
        '/donatorAddProduct': (context) => DonatorAddProductPage(),
      },

      // Route Listimizde olmayan bir route geldiyse hata döndür.
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Text('Bir şeyler ters gitti. Böyle bir sayfa bulunmuyor.'),
          ),
        ),
      ),
    );
  }
}
