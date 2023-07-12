import 'package:e_commerce/services/apis/all_products.dart';
import 'package:e_commerce/services/repository/all_products_repo.dart';
import 'package:e_commerce/ui/details_page/widgets/listview.dart';
import 'package:e_commerce/ui/home_page/widgets/textfield.dart';
import 'package:e_commerce/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../../services/models/product_model/products_model.dart';

// ignore: must_be_immutable
class DetailsPage extends StatefulWidget {
  int? id;
  // final APiProvider aPiProvider;
  DetailsPage({
    super.key,
    required this.id,
  });

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // late AllProductsRepository repo;
  ProductsModel? data;
  TextEditingController titlecont = TextEditingController();
  TextEditingController pricecont = TextEditingController();
  TextEditingController desccont = TextEditingController();
  TextEditingController imagecont = TextEditingController();
  TextEditingController catcont = TextEditingController();
  d() async {
    final daa = await AllProductsRepository(aPiProvider: APiProvider())
        .fetchProductsByID(widget.id!.toInt());

    data = daa[0];

    (data);
  }

  @override
  void initState() {
    d();

    super.initState();
  }

  @override
  void dispose() {
    titlecont.dispose();
    pricecont.dispose();
    desccont.dispose();
    imagecont.dispose();
    catcont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext dcontext) {
    return Scaffold(
      backgroundColor: AppColors.mainBg,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: AppColors.mainBg,
        title: const Text("Details"),
        actions: [
          IconButton(
            onPressed: () {
              titlecont.text = data!.title;
              pricecont.text = data!.price.toString();
              desccont.text = data!.description;
              imagecont.text = data!.image;
              catcont.text = data!.category;
              showDialog(
                context: _scaffoldKey.currentContext!,
                builder: (BuildContext context) {
                  return Dialog(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      height: 500,
                      child: Column(
                        children: [
                          const Text(
                            "Update",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          MyTextField(controller: titlecont),
                          const SizedBox(
                            height: 5,
                          ),
                          MyTextField(controller: pricecont),
                          const SizedBox(
                            height: 5,
                          ),
                          MyTextField(controller: desccont),
                          const SizedBox(
                            height: 5,
                          ),
                          MyTextField(controller: imagecont),
                          const SizedBox(
                            height: 5,
                          ),
                          MyTextField(controller: catcont),
                          const SizedBox(
                            height: 5,
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                ProductsModel product = ProductsModel(
                                    title: titlecont.text,
                                    price: double.parse(pricecont.text),
                                    description: desccont.text,
                                    category: catcont.text,
                                    image: imagecont.text);
                                Navigator.pop(context);

                                // ignore: unused_local_variable
                                final d = await AllProductsRepository(
                                        aPiProvider: APiProvider())
                                    .addProductUpdate(
                                        product, widget.id!.toInt());

                                ScaffoldMessenger.of(dcontext).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "${data!.id} dagi element o'chirildi")));
                              },
                              child: const Text("Update Product"))
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            icon: const Icon(
              Icons.edit,
            ),
          ),
          IconButton(
            onPressed: () async {
              // ignore: use_build_context_synchronously
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    actions: [
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "NO",
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          final deleted = await AllProductsRepository(
                                  aPiProvider: APiProvider())
                              .deleteProductByID(widget.id!.toInt());
                          final d = deleted[0];
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(dcontext).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Column(
                                children: [
                                  Text(
                                      "${d.title} Nomli mahsulot muvaffaqiyatli o'chirildi!"),
                                ],
                              ),
                            ),
                          );
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Yes",
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(
              Icons.delete,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          12,
        ),
        child: ListviewFuture(widget: widget),
      ),
    );
  }
}
