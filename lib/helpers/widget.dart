import 'package:flutter/material.dart';

Widget textInput(
    {required TextEditingController controller,
    String? hintText,
    bool isNotValidate = false,
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
          errorText: isNotValidate ? 'enter proper info' : null,
          border: InputBorder.none,
          hintText: hintText,
        ),
      ),
    ),
  );
}

Widget textInputregister(
    {required TextEditingController controller,
    String? hintText,
    bool readOnly = false,
    String? Function(String?)? validator}) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.only(left: 15),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        readOnly: readOnly,
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
