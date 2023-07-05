import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../pages/secondary_pages/about_page.dart';
import '../pages/secondary_pages/profile_page.dart';
import '../providers/profile_provider.dart';

class DrawarWidget extends StatefulWidget {
  const DrawarWidget({super.key});

  @override
  State<DrawarWidget> createState() => _DrawarWidgetState();
}

class _DrawarWidgetState extends State<DrawarWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height,
        child: Consumer<ProfileProvider>(builder: (context, provider, child) {
          return Column(
            children: [
              Container(
                color: Colors.green[700],
                width: double.infinity,
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        provider.profile!.user!.name!,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Text(
                        provider.profile!.user!.email!,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(
                            user: provider.profile!.user!,
                          ),
                        ),
                      ),
                      title: const Text(
                        "Profile",
                        style: TextStyle(color: Colors.black),
                      ),
                      leading: const FaIcon(
                        Icons.person,
                        color: Colors.black,
                      ),
                    ),
                    ListTile(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AboutPage(),
                          )),
                      title: const Text(
                        "about",
                        style: TextStyle(color: Colors.black),
                      ),
                      leading: const FaIcon(
                        Icons.info,
                        color: Colors.black,
                      ),
                    ),
                    ListTile(
                      onTap: () async {
                        bool islogout = await Provider.of<ProfileProvider>(
                                context,
                                listen: false)
                            .logout();
                        if (mounted && islogout) {
                          // Navigator.pushAndRemoveUntil(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const SignInPage(),
                          //   ),
                          //   (route) => false,
                          // );
                        } else {
                          SmartDialog.showToast("Something is wrong",
                              alignment: Alignment.center);
                        }
                      },
                      title: const Text(
                        "Log out",
                        style: TextStyle(color: Colors.black),
                      ),
                      leading: const FaIcon(
                        Icons.logout,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
