import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_1/helpers/constants.dart';
import 'change_password.dart';
import 'package:http/http.dart' as http;

class EmailVerification extends StatefulWidget {
  final String email;
  const EmailVerification({
    super.key,
    required this.email,
  });

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  final TextEditingController _otpController = TextEditingController();

  Future<void> verifyOTP() async {
    final otp = _otpController.text.trim();
    if (otp.isEmpty) {
      // Handle empty OTP field error
      return;
    }

    const url = 'http://10.0.2.2:8000/api/verifyotp';
    var data = json.encode(
      {
        'otp': otp,
        'email': widget.email,
      },
    );
    debugPrint(data);
    final response = await http.post(Uri.parse(url),
        body: data, headers: {"Content-Type": "application/json"});
    if (mounted && response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return ChangePassword(
            otp: otp,
            email: widget.email,
          );
        }),
      );
    } else {
      // OTP verification failed, handle the error
      print('OTP verification failed');
    }
  }

  @override
  void dispose() {
    _otpController.dispose();
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
              "Email verification ",
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
              "we have sent a code to your email ",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.grey),
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
                controller: _otpController,
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: 'OTP Code'),
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
            onTap: verifyOTP,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(17)),
              child: const Center(
                  child: Text(
                " Verify OTP",
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
              "didn't recieve the code ?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {},

              //  () {
              //   Navigator.pushReplacement(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => const ChangePassword(),
              //       ));
              // },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Implement resend OTP functionality here
                    },
                    child: const Text(
                      " resend OTP ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
