import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_1/pages/auth_pages/login_page.dart';
import 'package:flutter_ecommerce_1/providers/profile_provider.dart';
import 'package:flutter_ecommerce_1/start.dart';
import 'package:provider/provider.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  Future<bool>? isLoaded;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isLoaded ??= init2();
  }

  Future<bool> init2() async {
    return await Provider.of<ProfileProvider>(context).authWithToken();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, provider, child) {
        return provider.profile != null
            ? const StartPage()
            : const SignInPage();
      },
    );
  }
}
