import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_1/pages/login_page.dart';
import 'package:flutter_ecommerce_1/providers/profile_provider.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({
    Key? key,
  }) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    // Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool islogout =
              await Provider.of<ProfileProvider>(context, listen: false)
                  .logout();
          if (mounted && islogout) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const SignInPage(),
              ),
              (route) => false,
            );
          } else {
            SmartDialog.showToast("Something is wrong",
                alignment: Alignment.center);
          }
        },
      ),
      body: Consumer<ProfileProvider>(builder: (context, provider, child) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(provider.profile.user!.email!),
            ],
          ),
        );
      }),
    );
  }
}
