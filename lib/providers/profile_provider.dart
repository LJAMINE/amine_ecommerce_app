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

  Future<bool> updateProfile(
    User newProfile, {
    required String fullname,
    required String id,
    required String phoneNumber,
  }) async {
    try {
      SmartDialog.showLoading();

      var requestBody = {
        "phoneNumber": phoneNumber,
        "name": fullname,
      };

      var jsonBody = jsonEncode(requestBody);

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var token = sharedPreferences.getString("token");

      var response = await https.put(
        // Uri.parse("${url}profile"),
        Uri.parse("${url}profile/$id"),
        headers: {
          "Content-Type": "application/json",
          // "token": token!,
          "Authorization": "Bearer $token",
        },

        body: jsonBody,
      );
      print(token);
      SmartDialog.dismiss();

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        profile = Profile.fromJson(jsonResponse);
        notifyListeners();

        return true;
      } else {
        print(response.body);
        return false;
      }
    } catch (e) {
      SmartDialog.dismiss();
      log(e.toString());
      return false;
    }
  }

  Future<bool> registerUser({
    required String email,
    required String password,
    required String phoneNumber,
    required String fullname,
  }) async {
    try {
      SmartDialog.showLoading();

      var requestBody = {
        "email": email,
        "password": password,
        "phoneNumber": phoneNumber,
        "name": fullname,
      };

      var jsonBody = jsonEncode(requestBody);

      var response = await https.post(
        Uri.parse("${url}signup"),
        headers: {"Content-Type": "application/json"},
        body: jsonBody,
      );

      SmartDialog.dismiss();

      if (response.statusCode == 200) {
        return true;
      } else {
        print("error in register");
        return false;
      }
    } catch (e) {
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
        Uri.parse("${url}signin"),
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
    } catch (e) {
      debugPrint("Error: $e");
      return null;
    }
  }

  Future<bool> logout() async {
    var response = await https.get(
      Uri.parse("${url}signout"),
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
        Uri.parse("${url}authwithtoken"),
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
}

 


//  Future<bool> editProfile(Profile profile) async {
//     try {
//       SmartDialog.showLoading();
//       String? photoURL;
//       if (imageFile != null) {
//         Reference reference;
//         reference = FirebaseStorage.instance.ref("images/${imageFile!.name}");
//         await reference.putFile(File(imageFile!.path));

//         photoURL = await reference.getDownloadURL();
//         imageFile = null;
//       }

//       await FirebaseFirestore.instance
//           .collection("users")
//           .doc(profile.id)
//           .update({
//         "firstName": profile.firstName,
//         "lastName": profile.lastName,
//         "image": photoURL ?? profile.image,
//       });
//       return true;
//     } catch (e) {
//       SmartDialog.dismiss();
//       return false;
//     } finally {
//       SmartDialog.dismiss();
//     }
//   }