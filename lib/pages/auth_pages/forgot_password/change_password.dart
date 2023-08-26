import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_1/helpers/constants.dart';
import 'package:flutter_ecommerce_1/index.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:http/http.dart' as http;

class ChangePassword extends StatefulWidget {
  final String email;
  final String otp;
  const ChangePassword({super.key, required this.otp, required this.email});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _confirmPasswordcontroller =
      TextEditingController();

  Future<void> resetPassword() async {
    if (formKey.currentState!.validate()) {
      final password = _passwordcontroller.text.trim();
      final confirmPassword = _confirmPasswordcontroller.text.trim();

      const url = 'http://10.0.2.2:8000/api/resetPassword';

      var data = {
        'email': widget.email,
        'password': password,
        'confirmPassword': confirmPassword,
        'otp': widget.otp,
      };
      debugPrint(json.encode(data));

      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{"Content-Type": "application/json"},
        body: json.encode(data),
      );

      if (mounted && response.statusCode == 200) {
        SmartDialog.showToast("password updated successfly");

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const IndexPage(),
          ),
          (route) => false,
        );
      } else {
        debugPrint(response.body);
      }
    }
  }

  // void resetPassword() async {
  //   final email = _emailcontroller.text.trim();
  //   final password = _passwordcontroller.text.trim();
  //   final confirmPassword = _confirmPasswordcontroller.text.trim();

  //   if (password.isEmpty || confirmPassword.isEmpty) {
  //     // Handle empty password fields error
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: const Text('Failure'),
  //           content: const Text('Password or confirm password are empty !'),
  //           actions: <Widget>[
  //             TextButton(
  //               child: const Text('OK'),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //                 // Perform additional actions after password reset failure
  //               },
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //     print('password is empty');
  //     return;
  //   }

  //   if (password != confirmPassword) {
  //     // Handle password mismatch error
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: const Text('Failure'),
  //           content: const Text('Password and confirm password are different!'),
  //           actions: <Widget>[
  //             TextButton(
  //               child: const Text('OK'),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //                 // Perform additional actions after password reset failure
  //               },
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //     print('password and confirm is different ');

  //     return;
  //   }

  //   // Passwords match, proceed with password reset logic
  //   // Example password reset logic:
  //   bool resetSuccess = true; // Set to false if reset fails

  //   if (resetSuccess) {
  //     // Password reset succeeded
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: const Text('Success'),
  //           content: const Text('Password reset succeeded!'),
  //           actions: <Widget>[
  //             TextButton(
  //               child: const Text('OK'),
  //               onPressed: () {
  //                 Navigator.push(context, MaterialPageRoute(builder: (context) {
  //                   return const SignInPage();
  //                 }));
  //                 // Perform additional actions after password reset success
  //               },
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  //   const url = 'http://10.0.2.2:8000/api/resetPassword';

  //   // ignore: unused_local_variable
  //   final response = await http.post(
  //     Uri.parse(url),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json',
  //     },
  //     body: jsonEncode(<String, String>{
  //       'email': email, // Replace with the user's email
  //       'password': password,
  //       'confirmPassword': confirmPassword,
  //     }),
  //   );
  //   // Clear the text fields
  //   _passwordcontroller.clear();
  //   _confirmPasswordcontroller.clear();
  // }

  @override
  void dispose() {
    _passwordcontroller.dispose();
    _confirmPasswordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: Form(
        key: formKey,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Change the Password  ",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 40),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 26),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "new password ",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.black87),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: TextFormField(
                  obscureText: true,
                  controller: _passwordcontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "new password is required";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: 'new password'),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 26),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "confirm password ",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.black87),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: TextFormField(
                  validator: (value) {
                    if (value == _passwordcontroller.text) {
                      return null;
                    } else {
                      return "password is not correct";
                    }
                  },
                  obscureText: true,
                  controller: _confirmPasswordcontroller,
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: 'confirm password'),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: GestureDetector(
              onTap: resetPassword,
              //  () {
              //   Navigator.push(context, MaterialPageRoute(builder: (context) {
              //     return const ChangePassword();
              //   }));
              // },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(17)),
                child: const Center(
                    child: Text(
                  " Reset Password",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                )),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
