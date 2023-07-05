import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/widget.dart';
import '../../models/profile.dart';
import '../../providers/profile_provider.dart';

class ProfilePage extends StatefulWidget {
  final User user;

  const ProfilePage({super.key, required this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _fullnamecontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  // late final TextEditingController _phonecontroller;
  @override
  void initState() {
    _emailcontroller.text = widget.user.email!;
    _fullnamecontroller.text = widget.user.name!;
    _phonecontroller.text = widget.user.phoneNumber!;
    // _phonecontroller = TextEditingController(text: widget.profile.phoneNumber);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green[400],
          centerTitle: true,
          title: const Text("Profile")),
      body: Consumer<ProfileProvider>(
        builder: (context, profile, child) {
          return Container(
            padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  textInputregister(
                    controller: _fullnamecontroller,
                    hintText: "fullname",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Please enter The fullname");
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  textInputregister(
                    controller: _emailcontroller,
                    readOnly: true,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  textInputregister(
                    controller: _phonecontroller,
                    hintText: "phoneNumber",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Please enter The phoneNumber");
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                              fontSize: 15,
                              letterSpacing: 2,
                              color: Colors.black),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            User newProfile = User()
                              ..name = _fullnamecontroller.text
                              ..phoneNumber = _phonecontroller.text;

                            var x = await profile.updateProfile(
                              newProfile,
                              fullname: _fullnamecontroller.text,
                              phoneNumber: _phonecontroller.text,
                              id: widget.user.sId!,
                            );
                            if (!mounted) {
                              return;
                            }

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  x
                                      ? "Edit contact Success"
                                      : "failed to Edit contact",
                                ),
                              ),
                            );
                            // if (x) {
                            //   // for show update right now
                            //   await profile.getProfile();
                            //   if (mounted) {
                            //     Navigator.pop(context);
                            //   }
                            // }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        child: const Text(
                          "Save",
                          style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 2,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
