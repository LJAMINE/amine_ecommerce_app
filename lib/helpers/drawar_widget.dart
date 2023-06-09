import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        width: MediaQuery.of(context).size.width * 0.65,
        height: MediaQuery.of(context).size.height,
        child: Consumer<ProfileProvider>(builder: (context, provider, child) {
          return Column(
            children: [
              Text(
                provider.profile!.user!.name!,
                //style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              Text(
                provider.profile!.user!.email!,
                //style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          );
        }),
      ),
    );

    // Consumer<ProfileProvider>(builder: (context, provider, child) {
    //   return SizedBox(
    //     width: MediaQuery.of(context).size.width * 0.6,
    //     child: const Column(
    //       children: [
    // Container(
    //   color: Colors.green[700],
    //   width: double.infinity,
    //   height: 200,
    //   padding: const EdgeInsets.only(top: 20),
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       Container(
    //         margin: const EdgeInsets.only(bottom: 10),
    //         height: 70,
    //         decoration: const BoxDecoration(
    //           shape: BoxShape.circle,
    //           image: DecorationImage(
    //             image: AssetImage(""),
    //           ),
    //         ),
    //       ),
    //       Text(
    //         provider.profile.user!.name!,
    //         style:
    //             const TextStyle(color: Colors.white, fontSize: 20),
    //       ),
    //       Text(
    //         provider.profile.user!.email!,
    //         style:
    //             const TextStyle(color: Colors.white, fontSize: 20),
    //       ),
    //     ],
    //   ),
    // ),
    // Expanded(
    //   child: ListView(
    //     children: const [
    //       ListTile(
    //         // onTap: () => Navigator.push(
    //         //     context,
    //         //     MaterialPageRoute(
    //         //       builder: (context) => ProfilePage(
    //         //         profile: profileProvider.profile,
    //         //       ),
    //         //     )),
    //         title: Text(
    //           "Profile",
    //           style: TextStyle(color: Colors.white),
    //         ),
    //         leading: FaIcon(
    //           Icons.person,
    //           color: Colors.white,
    //         ),
    //       ),
    //       ListTile(
    //         // onTap: () => Navigator.push(
    //         //     context,
    //         //     MaterialPageRoute(
    //         //       builder: (context) => const AboutPage(),
    //         //     )),
    //         title: Text(
    //           "about",
    //           style: TextStyle(color: Colors.white),
    //         ),
    //         leading: FaIcon(
    //           Icons.info,
    //           color: Colors.white,
    //         ),
    //       ),
    //       ListTile(
    //         // onTap: signout,
    //         title: Text(
    //           "Log out",
    //           style: TextStyle(color: Colors.white),
    //         ),
    //         leading: FaIcon(
    //           Icons.logout,
    //           color: Colors.white,
    //         ),
    //       ),
    //     ],
    //   ),
    // ),
    //       ],
    //     ),
    //   );
    // });
  }
}
