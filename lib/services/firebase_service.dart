import 'dart:convert';
import 'dart:io';
import 'package:hackathon_project_v1/request/user_auth_error_message.dart';
import 'package:hackathon_project_v1/request/user_request.dart';
import 'package:http/http.dart' as http;

class FirebaseServices {
  static const String FIREBASE_URL =
      "https://flutterfirebaselogin-bfa37.firebaseio.com/";

  static const String FIREBASE_AUTH_URL =
      "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDmeOm56jnhYLCtHGrpjmh0Sa07IAvm-Is";

  Future postUser(UserRequest request) async {
    var jsonModel = json.encode(request.toJson());
    final response =
        await http.post(Uri.parse(FIREBASE_AUTH_URL), body: jsonModel);

    switch (response.statusCode) {
      case HttpStatus.ok:
        return true;
      default:
        var errorJson = json.decode(response.body);
        var error = FirebaseAuthErrorMessage.fromJson(errorJson);
        return error;
    }
  }
}
