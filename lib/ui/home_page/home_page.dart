import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/db_bloc/db_bloc.dart';
import 'package:e_commerce/services/apis/all_products.dart';
import 'package:e_commerce/services/models/my_cart_model.dart';
import 'package:e_commerce/services/models/product_model/products_model.dart';
import 'package:e_commerce/ui/details_page/details_page.dart';
import 'package:e_commerce/ui/home_page/add_page.dart';
import 'package:e_commerce/ui/home_page/shimm.dart';
import 'package:e_commerce/ui/home_page/widgets/cart.dart';
import 'package:e_commerce/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/services/repository/all_products_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.apiProvider});
  final APiProvider apiProvider;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AllProductsRepository rePo;
  String? category;
  // agar categoriya bilan qilmoqchi bo'lsa /category/electronics yoziladi else bo'sh bo'ladi
  String? sort;
  int? limit;

  Map<String, String> categoryDisplayTextMap = {
    '/categories': 'All Categories',
    '/category/electronics': 'Electronics',
    '/category/jewelery': 'Jewelry',
    "/category/men's clothing": "Men's Clothing",
    "/category/women's clothing": "Women's Clothing",
  };
  List<String> categoryOptions = [
    '',
    '/category/electronics',
    '/category/jewelery',
    "/category/men's clothing",
    "/category/women's clothing",
  ];

  @override
  void initState() {
    rePo = AllProductsRepository(aPiProvider: widget.apiProvider);
    super.initState();
    category = categoryOptions[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBg,
      appBar: AppBar(
        title: const Text("Market"),
        centerTitle: true,
        backgroundColor: AppColors.mainBg,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoryOptions.length,
                itemBuilder: (context, index) {
                  String value = categoryOptions[index];
                  String displayText = categoryDisplayTextMap[value] ?? 'All';
                  bool isSelected = value == category;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        category = value;
                      });
                    },
                    child: Container(
                      height: 40,
                      width: 120,
                      margin: const EdgeInsets.only(right: 10, bottom: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: isSelected
                              ? AppColors.primaryButton
                              : Colors.red[300]),
                      child: Center(
                        child: Text(
                          displayText,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: rePo.fetchAllProducts(category.toString()),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const ProductShimmer();
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData) {
                    return const Center(
                      child: Text('No data available'),
                    );
                  }

                  final data = snapshot.data;

                  return GridView(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        mainAxisExtent: 300,
                        // childAspectRatio: 0.6
                      ),
                      children: [
                        ...List.generate(data.length, (index) {
                          ProductsModel products = data[index];
                          return ZoomTapAnimation(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailsPage(id: products.id),
                                )),
                            child: Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  //  margin: const EdgeInsets.only(left: 24,right: 24),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: AppColors.itemBg,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          color: Colors.white,
                                          width: 1150,
                                          child: CachedNetworkImage(
                                            imageUrl: products.image,
                                            fit: BoxFit.scaleDown,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      RatingStars(
                                        starCount: 5,
                                        value: products.rating!.rate,
                                        valueLabelVisibility: false,
                                        starSize: 14,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        products.title.substring(0, 10),
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "${products.price.toString()} \$",
                                        style: const TextStyle(
                                            fontSize: 20,
                                            color: AppColors.saleHot),
                                      )
                                    ],
                                  ),
                                ),
                                CartPage(products: products),
                              ],
                            ),
                          );
                        }),
                      ]);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
