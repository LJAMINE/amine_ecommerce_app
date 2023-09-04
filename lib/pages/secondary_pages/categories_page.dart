import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_1/helpers/config.dart';
import 'package:flutter_ecommerce_1/helpers/constants.dart';
import 'package:flutter_ecommerce_1/helpers/search.dart';
import 'package:flutter_ecommerce_1/models/categorie.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../../helpers/productgridtile.dart';
import '../../providers/categories_provider.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final TextEditingController searchController = TextEditingController();
  int type = 1;

  Future<bool>? isLoaded;
  @override
  void initState() {
    isLoaded =
        Provider.of<CategoryProvider>(context, listen: false).fetchCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final categoryProvider = Provider.of<CategoryProvider>(context);

    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: SearchWidget(
            searchController: searchController,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        typeWidegt(),
        const SizedBox(
          height: 20,
        ),
        Consumer<CategoryProvider>(builder: (context, categoryProvider, child) {
          return FutureBuilder(
              future: isLoaded,
              builder: (context, snp) {
                if (!snp.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Expanded(
                  child: type == 1
                      ? gridListWidget(categoryProvider.categories)
                      : listWidget(categoryProvider.categories),
                );
              });
        }),
      ],
    );
  }

  ListView listWidget(List<Category> categories) {
    return ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              title: Text(category.name!,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              leading: ExtendedImage.network(
                url + category.photo!,
                width: 50,
                fit: BoxFit.fill,
                cache: true,
                shape: BoxShape.circle,
              ),
            ),
          );
        });
  }

  MasonryGridView gridListWidget(List<Category> categories) {
    return MasonryGridView.builder(
        itemCount: categories.length,
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        itemBuilder: (context, index) {
          final category = categories[index];
          return GridTile(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              height: 170,
              child: ProductGridTileWidget(
                imageUrl: url + category.photo!,
                name: category.name!,
              ),
            ),
          );
        });
  }

  Row typeWidegt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              type = 2;
            });
          },
          child: PhosphorIcon(
            PhosphorIcons.bold.listDashes,
            size: 30,
            color: type == 2 ? kPrimaryColor : Colors.black,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              type = 1;
            });
          },
          child: PhosphorIcon(
            PhosphorIcons.bold.dotsNine,
            size: 30,
            color: type == 1 ? kPrimaryColor : Colors.black,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
