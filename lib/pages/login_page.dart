import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_1/models/profile.dart';
import 'package:flutter_ecommerce_1/pages/register_page.dart';
import 'package:flutter_ecommerce_1/helpers/constants.dart';
import 'package:flutter_ecommerce_1/providers/profile_provider.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helpers/page_title_bar.dart';
import '../helpers/upside.dart';
import '../helpers/google.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late SharedPreferences prefs;
  // ignore: prefer_final_fields
  bool _isNotValidate = false;
  bool isPasswrodVisible = false;

  @override
  void initState() {
    super.initState();
    //initSharedpref();
  }

  // void initSharedpref() async {
  //   prefs = await SharedPreferences.getInstance();
  // }

  signinMethode(
    ProfileProvider profileProvider,
  ) async {
    if (formKey.currentState!.validate()) {
      Profile? profile = await profileProvider.signInUser(
          email: _emailcontroller.text, password: _passwordcontroller.text);

      if (profile != null && mounted) {
        // Navigator.pushAndRemoveUntil(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => const HomePage(),
        //   ),
        //   (route) => false,
        // );
      } else {
        SmartDialog.showToast("Something is wrong",
            alignment: Alignment.center);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Consumer<ProfileProvider>(
            builder: (context, profileProvider, child) {
          return SingleChildScrollView(
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
                    child: Form(
                      key: formKey,
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
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                          errorText: _isNotValidate
                                              ? 'enter proper info'
                                              : null,
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
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      obscureText: isPasswrodVisible,
                                      decoration: InputDecoration(
                                        errorText: _isNotValidate
                                            ? 'enter proper info'
                                            : null,
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
                                  onTap: () => signinMethode(profileProvider),
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        color: kPrimaryColor,
                                        borderRadius:
                                            BorderRadius.circular(17)),
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                  // const SizedBox(
                                  //   width: 20,
                                  // ),
                                  // Squaretile(
                                  //   // onTap: () => provider.signInwithGoogle(),
                                  //   imagepath: 'assets/images/facebook.png',
                                  //   onTap: () {},
                                  // ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }),
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
