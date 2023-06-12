import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'package:flutter_ecommerce_1/providers/profile_provider.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import '../../helpers/drawar_widget.dart';
import 'cart_page.dart';
import 'favourite_page.dart';

// import '../models/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  @override
  // void initState() {
  //   super.initState();
  //   //function get profile

  //   profile = Provider.of<ProfileProvider>(context, listen: false).getProfile();
  // }

  // Future<Profile>? profile;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(builder: (context, profilprov, child) {
      return Scaffold(
        bottomNavigationBar: Container(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: GNav(
                backgroundColor: Colors.black,
                color: Colors.white,
                activeColor: Colors.white,
                tabBackgroundColor: Colors.grey.shade800,
                gap: 8,
                padding: const EdgeInsets.all(17),
                tabs: [
                  GButton(
                    icon: Icons.home,
                    text: "Home",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ));
                    },
                  ),
                  GButton(
                    icon: Icons.favorite_border,
                    text: "Favorite",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LikesPage(),
                          ));
                    },
                  ),
                  GButton(
                    icon: Icons.card_giftcard,
                    text: "Cart",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CartPage(),
                          ));
                    },
                  ),
                  GButton(
                    icon: Icons.person,
                    text: "Profile",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilePage(
                              user: profilprov.profile!.user!,
                            ),
                          ));
                    },
                  ),
                ]),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.green[400],
          centerTitle: true,
          title: const Text("HomePage"),
        ),
        drawer: const DrawarWidget(),
        body: Consumer<ProfileProvider>(builder: (context, provider, child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(provider.profile!.user!.email!),
              ],
            ),
          );
        }),
      );
    });
  }
}
