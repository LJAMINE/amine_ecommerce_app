import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:http/http.dart' as https;
import 'package:shared_preferences/shared_preferences.dart';
import '../helpers/config.dart';
import '../models/profile.dart';

class ProfileProvider extends ChangeNotifier {
  Profile? profile;

  Future<bool> registerUser({
    required String email,
    required String password,
    required String confirmePassword,
    required String phoneNumber,
    required String fullname,
  }) async {
    //create user
    try {
      SmartDialog.showLoading();
      await
          // condition abderrahim

          SmartDialog.dismiss();

      return true;
    } catch (e) {
      // print(e);
      SmartDialog.dismiss();

      log(e.toString());
      return false;
    }
  }

//sign in

  Future<Profile?> signInUser({
    required String email,
    required String password,
  }) async {
    var requestBody = {
      "email": email,
      "password": password,
    };

    var jsonBody = jsonEncode(requestBody);

    try {
      var response = await https.post(
        Uri.parse("${url}users/signin"),
        headers: {"Content-Type": "application/json"},
        body: jsonBody,
      );

      var jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var myToken = jsonResponse['token'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', myToken);
        profile = Profile.fromJson(jsonResponse);
        notifyListeners();
        return profile;
      } else {
        return null;
      }
      // } else if (response.statusCode == 400) {
      //   print("User not found. Please sign up.");
      // } else if (response.statusCode == 401) {
      //   print("Email and password do not match.");
      // } else {
      //   print("Internal server error.");
      // }
    } catch (e) {
      debugPrint("Error: $e");
      return null;
    }
  }

  Future<bool> logout() async {
    var response = await https.get(
      Uri.parse("${url}users/signout"),
      headers: {"Content-Type": "application/json"},
    );
    // print(response.statusCode);
    if (response.statusCode == 200) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.clear();
      profile = null;
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> authWithToken() async {
    SmartDialog.showLoading();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    // print("========================== $token");
    if (token == null) {
      SmartDialog.dismiss();
      return false;
    }

    try {
      var response = await https.get(
        Uri.parse("${url}users/authwithtoken"),
        headers: {"Content-Type": "application/json", "token": token},
      );

      var jsonResponse = jsonDecode(response.body);
      log(response.body);
      if (response.statusCode == 200) {
        var myToken = jsonResponse['token'];

        sharedPreferences.setString('token', myToken);
        profile = Profile.fromJson(jsonResponse);
        notifyListeners();
        SmartDialog.dismiss();

        return true;
      } else {
        SmartDialog.dismiss();

        return false;
      }
    } catch (e) {
      debugPrint("Error: $e");
      SmartDialog.dismiss();

      return false;
    }
  }

  // void getUserdata(
  //   BuildContext context,
  // ) async {
  //   try {
  //     var userProvider = Provider.of<ProfileProvider>(context, listen: false);
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     String? token = prefs.getString('token');

  //     if (token == null) {
  //       prefs.setString("token", '');
  //     }

  //     var tokenRes = await https.post(
  //       Uri.parse("${url}tokenIsValid"),
  //       headers: {
  //         "Content-Type": "application/json",
  //         "token": token!,
  //       },
  //     );

  //     var response = jsonDecode(tokenRes.body);

  //     if (response == true) {
  //       https.Response userRes = await https.get(
  //         Uri.parse(url),
  //         headers: {
  //           "Content-Type": "application/json",
  //           "token": token,
  //         },
  //       );

  //       // userProvider.setUser(userRes.body);  abderahimmmmm
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // Future<Profile> getProfile() async {
  //   DocumentSnapshot documentSnapshot =
  //       await firestore.collection("users").doc(auth.currentUser!.uid).get();

  //   print("========================= $documentSnapshot");

  //   profile = Profile.fromJson(documentSnapshot);
  //   // print(profile);
  //   notifyListeners();

  //   return profile;
  // }

  // sign up

  //    void registerUser() async {
  //   if (_emailcontroller.text.isNotEmpty &&
  //       _passwordcontroller.text.isNotEmpty &&
  //       _fullnamecontroller.text.isNotEmpty) {
  //     var requestBody = {
  //       "email": _emailcontroller.text,
  //       "password": _passwordcontroller.text,
  //       "name": _fullnamecontroller.text
  //     };
  //     var jsonBody = jsonEncode(requestBody);
  //     print(jsonBody);

  //     var response = await https.post(
  //       Uri.parse("${url}users/signup"),
  //       headers: {"Content-Type": "application/json"},
  //       body: jsonBody,
  //     );
  //     print(response.body);

  //     var jsonResponse = jsonDecode(response.body);
  //     print(jsonResponse['status']);

  //     if (jsonResponse = true) {
  //       // ignore: use_build_context_synchronously
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => const HomePage()));
  //     } else {
  //       print("SomeThing Went Wrong");
  //     }
  //   } else {
  //     setState(() {
  //       _isNotValidate = true;
  //     });
  //   }
  // }
}
