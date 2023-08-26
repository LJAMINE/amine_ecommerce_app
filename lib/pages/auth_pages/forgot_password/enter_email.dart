import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_1/helpers/constants.dart';
import 'package:http/http.dart' as http;
import 'email_verification_page.dart';

class EnterEmailpage extends StatefulWidget {
  const EnterEmailpage({super.key});

  @override
  State<EnterEmailpage> createState() => _EnterEmailpageState();
}

class _EnterEmailpageState extends State<EnterEmailpage> {
  final _emailcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailcontroller.text = "aminelmgrmj@gmail.com";
  }

  Future<void> sendOTP() async {
    var email = _emailcontroller.text.trim();
    print('Email: $email'); // Add this line for debugging

    if (email.isNotEmpty) {
      try {
        const url = 'http://10.0.2.2:8000/api/sendemail';
        print('Request URL: $url'); // Add this line for debugging

        final response = await http.post(Uri.parse(url),
            body: jsonEncode({"email": email}),
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json"
            });

        if (response.statusCode == 200) {
          // Parse the response body to get the OTP code
          final responseData = jsonDecode(response.body);
          print(responseData);
          // Navigate to the OTP verification page with the OTP code
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return EmailVerification(
                email: _emailcontroller.text,
              );
            }),
          );
        } else {
          print(
              'Failed to send OTP. Response status code: ${response.statusCode}');
          print('Response body: ${response.body}');
        }
      } catch (error) {
        print('Error sending OTP: $error');
      }
    } else {
      print('Email is required');
    }
  }

  @override
  void dispose() {
    _emailcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Enter Email   ",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 45),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "enter email so we could send you an OTP code ",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(
          height: 50,
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
              child: TextField(
                controller: _emailcontroller,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: 'Email'),
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
            onTap: sendOTP,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(17)),
              child: const Center(
                  child: Text(
                " Send ",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              )),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Didn't recieve the code ?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {
                // impement resend functionality
              },
              child: const Text(
                " Resend OTP ",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
