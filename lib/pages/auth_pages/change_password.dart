import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_1/helpers/constants.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
            child: const Padding(
              padding: EdgeInsets.only(left: 15),
              child: TextField(
                // controller: _emailcontroller,
                decoration: InputDecoration(
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
            child: const Padding(
              padding: EdgeInsets.only(left: 15),
              child: TextField(
                // controller: _emailcontroller,
                decoration: InputDecoration(
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
    );
  }
}
