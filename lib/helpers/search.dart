import 'package:flutter/material.dart';

import 'constants.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController searchController;
  const SearchWidget({
    super.key,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.search,
          color: kPrimaryColor,
        ),
        hintText: "Search",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kPrimaryColor),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
