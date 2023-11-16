import 'package:e_commerce/services/apis/all_products.dart';
import 'package:e_commerce/services/models/cart_model/cart_model.dart';
import 'package:e_commerce/services/models/product_model/products_model.dart';
import 'package:e_commerce/services/models/user_model/user_model.dart';
import 'package:e_commerce/services/repository/user_repo.dart';
import 'package:e_commerce/services/universal_response.dart';
import 'package:e_commerce/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key, required this.apiProvider});
  final APiProvider apiProvider;

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final box = GetStorage();
  late CartRepo userRepo;

  @override
  void initState() {
    userRepo = CartRepo(aPiProvider: widget.apiProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBg,
      appBar: AppBar(
        title: const Text("Admin Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: FutureBuilder(
          future: userRepo.getUsers(),
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
            final List<CartModel> dataa = snapshot.data;

            return ListView.builder(
              itemCount: dataa.length,
              itemBuilder: (BuildContext context, int index) {
                final data = dataa[index];

                return FutureBuilder<UniversalResponse>(
                    future: widget.apiProvider.getUserByID(data.userId),
                    builder: (context, snapshot) {
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
                      UserModel user = snapshot.data!.data;
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration:
                                const BoxDecoration(color: AppColors.itemBg),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.username,
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.grey),
                                ),
                                const Divider(color: Colors.grey),
                                FutureBuilder(
                                  future: Future.wait(
                                    data.products.map(
                                      (productEntry) => widget.apiProvider
                                          .getCartProductsByID(
                                              productEntry.productId),
                                    ),
                                  ),
                                  builder: (context,
                                      AsyncSnapshot<List<ProductsModel>>
                                          snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Center(
                                        child: Text('Error: ${snapshot.error}'),
                                      );
                                    } else if (!snapshot.hasData ||
                                        snapshot.data!.isEmpty) {
                                      return const Center(
                                        child: Text('No data available'),
                                      );
                                    }

                                    List<ProductsModel> productsList =
                                        snapshot.data!;

                                    return ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: data.products.length,
                                      itemBuilder: (BuildContext context,
                                          int productIndex) {
                                        ProductsModel product =
                                            productsList[productIndex];

                                        return ListTile(
                                          title: Text(product.title),
                                          subtitle: Text(
                                              'Quantity: ${data.products[index < data.products.length ? index : 0].quantity}'),
                                          // Other fields as needed
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ));
                    });
              },
            );
          },
        ),
      ),
    );
  }
}
