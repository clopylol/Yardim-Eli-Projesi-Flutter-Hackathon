import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserManagement {
  Widget handleAuth() {
    // return StreamBuilder(
    //     stream: FirebaseAuth.instance.authStateChanges(),
    //     builder: (BuildContext context, snapshot) {
    //       // if(snapshot.connectionState == ConnectionState.waiting{}
    //       if (snapshot.hasData) {
    //         return Dashboard();
    //       }
    //       return LoginScreen();
    //     });
  }

  // Kullanıcı Kaydı
  Future userSignUp(
      {String userName, String userPassword, String userRole}) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: userName, password: userPassword)
        .then((value) {
      var user = FirebaseAuth.instance.currentUser;
      FirebaseFirestore.instance.collection("profile").doc(userName).set({
        'role': userRole,
        'User Mail: ': userName,
        'User Password': userPassword,
        'User Uid': user.uid,
      }).whenComplete(() {
        print("$userName adlı kullanıcı $userRole olarak, kayıt oldu.");
      });
    });
  }

  // Kullanıcı Giriş
  userSignIn(
      {BuildContext context, String userName, String userPassword}) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: userName, password: userPassword)
        .then((value) {
      FirebaseFirestore.instance
          .collection("profile")
          .doc(userName)
          .get()
          .then((value) {
        print(value.data());
        var role = value.data()['role'];
        print(role);

        var result = "";

        if (role == "user") {
          result = '/userPage';
        }
        if (role == "donator") {
          result = '/donatorPage';
        }
        if (role == "admin") {
          result = '/adminPage';
        }

        Navigator.pushNamed(context, result);
      });
    });
  }

  // accessAuthorized(BuildContext context) {
  //   final user = FirebaseAuth.instance.currentUser;
  //   FirebaseFirestore.instance
  //       .collection('profile')
  //       .where('uid', isEqualTo: user.uid)
  //       .get()
  //       .then((doc) {
  //     if (doc.docs[0].exists) {
  //       if (doc.docs[0].data()['role'] == 'admin') {
  //         Navigator.of(context).push(
  //           MaterialPageRoute(builder: (context) {
  //             return AdminOnly();
  //           }),
  //         );
  //       } else if (doc.docs[0].data()['role'] == 'user') {
  //         Navigator.of(context).push(
  //           MaterialPageRoute(builder: (context) {
  //             return HomePage();
  //           }),
  //         );
  //       } else if (doc.docs[0].data()['role'] == 'donator') {
  //         Navigator.of(context).push(
  //           MaterialPageRoute(builder: (context) {
  //             return AdminOnly();
  //           }),
  //         );
  //       } else {
  //         print('Not Authorized');
  //       }
  //     }
  //   });
  // }

  signOut() {
    FirebaseAuth.instance.signOut();
  }
}
