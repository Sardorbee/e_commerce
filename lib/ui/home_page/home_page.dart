import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/services/apis/all_products.dart';
import 'package:e_commerce/ui/details_page/details_page.dart';
import 'package:e_commerce/ui/home_page/add_page.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/services/repository/all_products_repo.dart';

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
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
            ),
          ),
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
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          8,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: 40,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFD3B398),
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
                    color: const Color(0xFFD3B398),
                  ),
                  child: Center(
                    child: PopupMenuButton<int>(position: PopupMenuPosition.under,
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
                        style: TextStyle(fontSize: 18),
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
                    color: const Color(0xFFD3B398),
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
                        String displayText =
                            categoryDisplayTextMap[value] ?? 'All';
                        return PopupMenuItem<String>(
                          value: value,
                          child: Text(displayText),
                        );
                      }).toList();
                    },
                    child: Center(
                      child:  Text(
                        "Category",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    // Remove or set the icon property to null to disable the icon
                    // icon: null,
                  ),
                ),
              ],
            ),
            futureBuilder(),
          ],
        ),
      ),
    );
  }

  Expanded futureBuilder() {
    return Expanded(
      child: FutureBuilder(
        future:
            rePo.fetchAllProducts(category.toString(), sort.toString(), limit),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
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

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              final product = data[index];
              return ListTile(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsPage(
                          id: product.id, aPiProvider: widget.apiProvider),
                    )),
                leading: SizedBox(
                  width: 40,
                  child:
                      CachedNetworkImage(height: 50, imageUrl: product.image),
                ),
                title: Text(product.title),
                trailing: Text("${product.price.toString()} \$"),
              );
            },
          );
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