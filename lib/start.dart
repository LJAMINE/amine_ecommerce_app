import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_1/pages/secondary_pages/cart_page.dart';
import 'package:flutter_ecommerce_1/pages/secondary_pages/categories_page.dart';
import 'package:flutter_ecommerce_1/pages/secondary_pages/favourite_page.dart';
import 'package:flutter_ecommerce_1/providers/profile_provider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import '../../helpers/drawar_widget.dart';
import 'pages/secondary_pages/homepage.dart';

// import '../models/profile.dart';

class StartPage extends StatefulWidget {
  const StartPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final items = [
    const Icon(Icons.home),
    const Icon(Icons.favorite),
    PhosphorIcon(PhosphorIcons.bold.squaresFour),
    const Icon(Icons.card_giftcard),
    const Icon(Icons.person),
  ];
  int index = 2;

  String? title;

  // Future<Profile>? profile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.green,
        animationDuration: const Duration(milliseconds: 300),
        items: items,
        index: index,
        onTap: (selectedIndex) {
          setState(() {
            index = selectedIndex;
          });
          getData(index);
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        centerTitle: true,
        title: Text(getTitle(index: index)),
      ),
      drawer: const DrawarWidget(),
      body: Consumer<ProfileProvider>(builder: (context, provider, child) {
        return Container(child: getSlectedWidget(index: index));
      }),
    );
  }

  String getTitle({required int index}) {
    switch (index) {
      case 0:
        title = 'HomePage';
        break;
      case 1:
        title = 'Favourite';
        break;
      case 2:
        title = 'Categories';
        break;
      default:
        title = 'Cart';

        break;
      //       case 4:
      //     widget = ProfilePage(user: null,);
      //     break;
      // }
    }
    return title!;
  }

  Widget getSlectedWidget({required int index}) {
    Widget widget;
    switch (index) {
      case 0:
        widget = const HomePage();
        break;
      case 1:
        widget = const FavouritePage();
        break;
      case 2:
        widget = const CategoriesPage();
        break;
      default:
        widget = const CartPage();
        break;
      //       case 4:
      //     widget = ProfilePage(user: null,);
      //     break;
      // }
    }
    return widget;
  }

  getData(index) {
    switch (index) {
      case 0:
        getHomeData();
        break;
      case 1:
        print("1");

        break;
      case 2:
        print("2");

        break;
      default:
        print("3");

        break;
      //       case 4:
      //     widget = ProfilePage(user: null,);
      //     break;
      // }
    }
  }

  getHomeData() {
    //Provider.of<homeProvider>(context).function change is loded data
    // print("0");
  }
}
