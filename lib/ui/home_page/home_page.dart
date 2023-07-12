import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/services/apis/all_products.dart';
import 'package:e_commerce/services/models/product_model/products_model.dart';
import 'package:e_commerce/ui/details_page/details_page.dart';
import 'package:e_commerce/ui/home_page/add_page.dart';
import 'package:e_commerce/ui/home_page/shimm.dart';
import 'package:e_commerce/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/services/repository/all_products_repo.dart';
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

  List<String> sortOptions = ['asc', 'desc'];

  List<int> limitOptions = [5, 10, 15, 20];
  bool isMoreOptionsVisible = false;

  @override
  void initState() {
    rePo = AllProductsRepository(aPiProvider: widget.apiProvider);
    super.initState();
    category = categoryOptions[0];
    sort = sortOptions[0];
    limit = limitOptions[3];
    // fetchCategoriesFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBg,
      appBar: AppBar(
        backgroundColor: AppColors.mainBg,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AddPage(aPiProvider: widget.apiProvider),
                ),
              );
            },
            icon: const Icon(
              Icons.add,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                isMoreOptionsVisible = !isMoreOptionsVisible;
              });
              if (isMoreOptionsVisible == true) {
                Future.delayed(const Duration(seconds: 5)).then((value) {
                  setState(() {
                    isMoreOptionsVisible = false;
                  });
                });
              }
            },
            icon: const Icon(
              Icons.more_vert,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          8,
        ),
        child: Column(
          children: [
            AnimatedContainer(
              height: isMoreOptionsVisible ? 60 : 0,
              duration: const Duration(milliseconds: 200),
              child: MoreOptions(),
            ),
            category == categoryOptions[1]
                ? const Center(
                    child: Text(
                      "Electronics",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  )
                : category == categoryOptions[2]
                    ? const Center(
                        child: Text(
                          "Jewelry",
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                      )
                    : category == categoryOptions[3]
                        ? const Center(
                            child: Text(
                              "Men's Clothing",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24),
                            ),
                          )
                        : category == categoryOptions[4]
                            ? const Center(
                                child: Text(
                                  "Women's Clothing",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24),
                                ),
                              )
                            : const SizedBox(),
            futureBuilder(),
          ],
        ),
      ),
    );
  }

  Row MoreOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: 40,
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.primaryButton,
          ),
          child: Center(
            child: PopupMenuButton<String>(
              initialValue: sort,
              onSelected: (String newValue) {
                setState(() {
                  sort = newValue;
                });
              },
              itemBuilder: (BuildContext context) {
                return sortOptions.map((String value) {
                  return PopupMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                    ),
                  );
                }).toList();
              },
              // Remove or set the icon property to null to disable the icon
              // icon: null,
              child: const Center(
                child: Text(
                  "Sort",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
          height: 40,
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.primaryButton,
          ),
          child: Center(
            child: PopupMenuButton<int>(
              position: PopupMenuPosition.under,
              initialValue: limit,
              onSelected: (int? newValue) {
                setState(() {
                  limit = newValue;
                });
              },
              itemBuilder: (BuildContext context) {
                return limitOptions.map((int value) {
                  return PopupMenuItem<int>(
                    value: value,
                    // ignore: unrelated_type_equality_checks
                    child: Text(
                      value == '' ? "All" : value.toString(),
                    ),
                  );
                }).toList();
              },
              child: Text(
                limit.toString(),
                style: const TextStyle(fontSize: 18),
              ),
              // Remove or set the icon property to null to disable the icon
              // icon: null,
            ),
          ),
        ),
        Container(
          height: 40,
          width: 120,
          padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.primaryButton,
          ),
          child: PopupMenuButton<String>(
            initialValue: category,
            onSelected: (String newValue) {
              setState(() {
                category = newValue;
              });
            },
            itemBuilder: (BuildContext context) {
              return categoryOptions.map((String value) {
                String displayText = categoryDisplayTextMap[value] ?? 'All';
                return PopupMenuItem<String>(
                  value: value,
                  child: Text(displayText),
                );
              }).toList();
            },
            child: const Center(
              child: Text(
                "Category",
                style: TextStyle(fontSize: 18),
              ),
            ),
            // Remove or set the icon property to null to disable the icon
            // icon: null,
          ),
        ),
      ],
    );
  }

  Expanded futureBuilder() {
    return Expanded(
      child: FutureBuilder(
        future:
            rePo.fetchAllProducts(category.toString(), sort.toString(), limit),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ProductShimmer();
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
              //     physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                mainAxisExtent: 300,
                // childAspectRatio: 0.6
              ),
              children: [
                ...List.generate(data.length, (index) {
                  ProductsModel products = data[index];
                  return Stack(
                    children: [
                      ZoomTapAnimation(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailsPage(id: products.id),
                            )),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          //  margin: const EdgeInsets.only(left: 24,right: 24),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: AppColors.itemBg,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                    fontSize: 20, color: AppColors.saleHot),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ]);
        },
      ),
    );
  }
}


// Future<List<String>> fetchCategoriesFromAPI() async {
//     final response = await http.get(Uri.parse('https://fakestoreapi.com/products/categories')); // Replace 'API_URL' with your actual API endpoint

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       List<String> categories = List<String>.from(data);
//       return categories;
//     } else {
//       throw Exception('Failed to fetch categories from API');
//     }
//   }