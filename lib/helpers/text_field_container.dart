import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_1/helpers/constants.dart';

class TextFieldContainer extends StatelessWidget {
  const TextFieldContainer(this.child, {super.key});
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(29),
      ),
    );
  }
}
