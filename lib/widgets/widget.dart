import 'package:flutter/material.dart';

Widget textInput(
    {required TextEditingController controller,
    String? hintText,
    String? Function(String?)? validator}) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        validator: validator,
        //  (value) {
        //   if (value!.isEmpty) {
        //     return ("Please enter The full name");
        //   }
        //   return null;
        // },
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
        ),
      ),
    ),
  );
}
