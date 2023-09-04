import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ProductGridTileWidget extends StatelessWidget {
  final String imageUrl;
  final String name;

  const ProductGridTileWidget({
    super.key,
    required this.imageUrl,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return GridTile(
      footer: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15)),
          color: Colors.black.withOpacity(0.5),
        ),
        child: Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        child: ExtendedImage.network(
          imageUrl,
          height: 170,
          fit: BoxFit.fill,
          cache: true,
          borderRadius: const BorderRadius.all(Radius.circular(30.0)),
        ),
      ),
    );
  }
}
