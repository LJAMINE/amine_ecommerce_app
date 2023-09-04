import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_1/index.dart';
import 'package:flutter_ecommerce_1/providers/categories_provider.dart';
import 'package:flutter_ecommerce_1/providers/profile_provider.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final ProfileProvider profileProvider = ProfileProvider();

  // @override
  // void initState() {
  //   super.initState();
  //   profileProvider.getUserdata(context);
  // }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProfileProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CategoryProvider(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          builder: FlutterSmartDialog.init(),
          home: const IndexPage()
          // Provider.of<ProfileProvider>(context).profile.token!.isEmpty
          //     ? const RegisterPage()
          //     : const HomePage(),
          ),
    );
  }
}
