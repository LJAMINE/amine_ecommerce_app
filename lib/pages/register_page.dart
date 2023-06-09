import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_1/helpers/config.dart';
import 'package:flutter_ecommerce_1/pages/homepage.dart';
import 'package:flutter_ecommerce_1/pages/login_page.dart';
import 'package:flutter_ecommerce_1/helpers/constants.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../helpers/page_title_bar.dart';
import '../helpers/upside.dart';
import '../providers/profile_provider.dart';
import '../helpers/google.dart';
import 'package:http/http.dart' as https;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isPasswrodVisible = false;
  String dialcode = "";
  final _fullnamecontroller = TextEditingController();
  final _confirmpasswordcontroller = TextEditingController();
  final _phonecontroller = TextEditingController();
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  bool isNotValidate = false;

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    // _phonecontroller.dispose();
    super.dispose();
  }

  void registerUser() async {
    if (_emailcontroller.text.isNotEmpty &&
        _passwordcontroller.text.isNotEmpty &&
        _fullnamecontroller.text.isNotEmpty) {
      var requestBody = {
        "email": _emailcontroller.text,
        "password": _passwordcontroller.text,
        "name": _fullnamecontroller.text
      };
      var jsonBody = jsonEncode(requestBody);
      print(jsonBody);

      var response = await https.post(
        Uri.parse("${url}users/signup"),
        headers: {"Content-Type": "application/json"},
        body: jsonBody,
      );
      print(response.body);

      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse['status']);

      if (jsonResponse == true) {
        // ignore: use_build_context_synchronously
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      } else {
        print("SomeThing Went Wrong");
      }
    } else {
      setState(() {
        isNotValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body:
          Consumer<ProfileProvider>(builder: (context, profileProvider, child) {
        return SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                const Upside(imgUrl: "assets/images/login.png"),
                const PageTitleBar(
                  title: ("Register below with your details!"),
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
                          Column(
                            children: [
                              // textInput(
                              //   controller: _fullnamecontroller,
                              //   hintText: 'Full Name',
                              //   validator: (value) {
                              //     if (value!.isEmpty) {
                              //       return ("Please enter The full name");
                              //     }
                              //     return null;
                              //   },
                              // ),
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
                                      controller: _fullnamecontroller,
                                      decoration: InputDecoration(
                                          errorText: isNotValidate
                                              ? 'enter proper info'
                                              : null,
                                          border: InputBorder.none,
                                          hintText: 'Full name'),
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
                                    padding: const EdgeInsets.only(left: 15),
                                    child: TextField(
                                      controller: _emailcontroller,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                          errorText: isNotValidate
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
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Colors.white),
                                  ),

                                  // phone number

                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: InternationalPhoneNumberInput(
                                          locale: "US",

                                          keyboardAction: TextInputAction.done,
                                          onInputChanged: (PhoneNumber number) {
                                            dialcode = number.dialCode!;
                                          },
                                          onInputValidated: (bool value) {},
                                          selectorConfig: const SelectorConfig(
                                            selectorType: PhoneInputSelectorType
                                                .BOTTOM_SHEET,
                                          ),
                                          ignoreBlank: false,
                                          autoValidateMode:
                                              AutovalidateMode.disabled,
                                          selectorTextStyle: const TextStyle(
                                              color: Colors.black),

                                          //controller
                                          textFieldController: _phonecontroller,

                                          formatInput: false,
                                          maxLength: 9,
                                          // keyboardType:
                                          //     const TextInputType.numberWithOptions(
                                          //   signed: true,
                                          //   decimal: true,
                                          // ),
                                          cursorColor: Colors.black,
                                          inputDecoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    bottom: 15, left: 0),
                                            border: InputBorder.none,
                                            hintText: 'Phone Number',
                                            hintStyle: TextStyle(
                                                color: Colors.grey[700],
                                                fontSize: 16),
                                          ),
                                          onSaved: (PhoneNumber number) {
                                            log(number.toString());
                                          },
                                        ),
                                      ),
                                      Positioned(
                                        left: 90,
                                        top: 8,
                                        bottom: 8,
                                        child: Container(
                                          height: 40,
                                          width: 1,
                                          color: Colors.black.withOpacity(0.13),
                                        ),
                                      )
                                    ],
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
                                        errorText: isNotValidate
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
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: TextFormField(
                                      // add controller
                                      controller: _confirmpasswordcontroller,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      obscureText: isPasswrodVisible,
                                      validator: (value) {
                                        if (value == _passwordcontroller.text) {
                                          return null;
                                        } else {
                                          return "password is not correct";
                                        }
                                      },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: ' Confirm Password',
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
                                      // onTap: () {
                                      //   Navigator.push(context,
                                      //       MaterialPageRoute(
                                      //           builder: (context) {
                                      //     return const ForgotPasswordPage();
                                      //   }));
                                      // },
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
                                  onTap: () async {
                                    if (formKey.currentState!.validate()) {
                                      bool isregistred =
                                          await profileProvider.registerUser(
                                        email: _emailcontroller.text,
                                        password: _passwordcontroller.text,
                                        confirmePassword:
                                            _confirmpasswordcontroller.text,
                                        phoneNumber: _phonecontroller.text,
                                        fullname: _fullnamecontroller.text,
                                      );

                                      if (isregistred) {
                                        if (!mounted) return;
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomePage(),
                                            ));
                                      } else {
                                        SmartDialog.showToast("signup failed");
                                      }
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        color: kPrimaryColor,
                                        borderRadius:
                                            BorderRadius.circular(17)),
                                    child: const Center(
                                        child: Text(
                                      "Sign Up",
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
                                    "I am a member ?",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const SignInPage(),
                                          ));
                                    },
                                    child: const Text(
                                      " Login now",
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
                              ),
                              const SizedBox(
                                height: 20,
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
          ),
        );
      }),
    );
  }
}
