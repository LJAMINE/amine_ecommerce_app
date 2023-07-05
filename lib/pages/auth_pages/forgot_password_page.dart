import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_1/helpers/constants.dart';

import 'change_password.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  // final _emailcontroller = TextEditingController();
  @override
  void dispose() {
    // _emailcontroller.dispose();
    super.dispose();
  }

  // Future passwordReset() async {
  //   try {
  //     await FirebaseAuth.instance
  //         .sendPasswordResetEmail(email: _emailcontroller.text.trim());

  //     // ignore: use_build_context_synchronously
  //     showDialog(
  //       context: context,
  //       builder: (context) {
  //         return const AlertDialog(
  //           content: Text("Password reset link sent! Check your Email"),
  //         );
  //       },
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     // ignore: avoid_print
  //     print(e);
  //     // dialogue of error
  //     showDialog(
  //         context: context,
  //         builder: (context) {
  //           return AlertDialog(
  //             content: Text(e.message.toString()),
  //           );
  //         });
  //   }
  // }

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
            child: const Padding(
              padding: EdgeInsets.only(left: 15),
              child: TextField(
                // controller: _emailcontroller,
                decoration: InputDecoration(
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
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const ChangePassword();
              }));
            },
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
              onTap: () {
                // Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => const RegisterPage(),
                //     ));
              },
              child: const Text(
                " resend OTP ",
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
