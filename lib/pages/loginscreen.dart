import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_1/pages/register_page.dart';
import 'package:flutter_ecommerce_1/widgets/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../component/page_title_bar.dart';
import '../component/upside.dart';
import '../widgets/google.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _passwordcontroller = TextEditingController();
  final _emailcontroller = TextEditingController();
  bool isPasswrodVisible = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                const Upside(imgUrl: "assets/images/login.png"),
                const PageTitleBar(
                  title: ("Login to your account "),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 320),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),

                        const SizedBox(
                          height: 15,
                        ),
                        // const Text(
                        //   "or use your email account",
                        //   style: TextStyle(
                        //       color: Colors.grey,
                        //       fontFamily: 'OpenSans',
                        //       fontSize: 13,
                        //       fontWeight: FontWeight.w600),
                        // ),
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: TextField(
                                    controller: _emailcontroller,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Email'),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: TextField(
                                    controller: _passwordcontroller,
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: isPasswrodVisible,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Password',
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isPasswrodVisible =
                                                !isPasswrodVisible;
                                          });
                                        },
                                        icon: FaIcon(
                                          isPasswrodVisible
                                              ? FontAwesomeIcons.eye
                                              : FontAwesomeIcons.eyeSlash,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // Navigator.push(context,
                                      //     MaterialPageRoute(builder: (context) {
                                      //   return const ForgotPasswordPage();
                                      // }));
                                    },
                                    child: const Text(
                                      "Forgot Password?",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: kPrimaryColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),

                            //signin button

                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: GestureDetector(
                                // onTap: signIn,
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      color: kPrimaryColor,
                                      borderRadius: BorderRadius.circular(17)),
                                  child: const Center(
                                      child: Text(
                                    "Sign In",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  )),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 26,
                            ),

                            //not a member? register now
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Not a member ?",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const RegisterPage(),
                                        ));
                                  },
                                  child: const Text(
                                    " Register now",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    "Or continue with",
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Squaretile(
                                  // onTap: () => provider.signInwithGoogle(),
                                  imagepath: 'assets/images/google.png',
                                  onTap: () {},
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// iconButton(BuildContext context) {
//   return const Row(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       RoundedIcon(imageUrl: "assets/images/facebook.png"),
//       SizedBox(
//         width: 20,
//       ),
//       RoundedIcon(imageUrl: "assets/images/twitter.png"),
//       SizedBox(
//         width: 20,
//       ),
//       RoundedIcon(imageUrl: "assets/images/google.png"),
//     ],
//   );
// }
