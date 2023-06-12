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
                    height: 10,
                  ),
                  textInputregister(
                    controller: _emailcontroller,
                    readOnly: true,
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
