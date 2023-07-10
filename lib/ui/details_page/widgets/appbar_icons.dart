import 'package:flutter/material.dart';

import '../../../services/models/product_model/products_model.dart';
import '../../../services/repository/all_products_repo.dart';
import '../../home_page/widgets/textfield.dart';
import '../details_page.dart';

class AppbarIcons extends StatelessWidget {
  const AppbarIcons({
    super.key,
    required this.titlecont,
    required this.data,
    required this.pricecont,
    required this.desccont,
    required this.imagecont,
    required this.catcont,
    required this.widget,
  });

  final TextEditingController titlecont;
  final ProductsModel? data;
  final TextEditingController pricecont;
  final TextEditingController desccont;
  final TextEditingController imagecont;
  final TextEditingController catcont;
  final DetailsPage widget;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        titlecont.text = data!.title;
        pricecont.text = data!.price.toString();
        desccont.text = data!.description;
        imagecont.text = data!.image;
        catcont.text = data!.category;
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: Container(
                padding: const EdgeInsets.all(10),
                height: 500,
                child: Column(
                  children: [
                    const Text(
                      "Update",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                          final d =
                              await AllProductsRepository.addProductUpdate(
                                  product, widget.id!.toInt());
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("${data!.id}")));
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
    );
  }
}