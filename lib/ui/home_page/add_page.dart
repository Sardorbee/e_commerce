import 'package:e_commerce/ui/home_page/widgets/textfield.dart';
import 'package:flutter/material.dart';

import '../../services/models/product_model/products_model.dart';
import '../../services/repository/all_products_repo.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController titlecont = TextEditingController();
  TextEditingController pricecont = TextEditingController();
  TextEditingController descriptioncont = TextEditingController();
  TextEditingController categorycont = TextEditingController();
  TextEditingController imagecont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                const SizedBox(
                  height: 5,
                ),
                MyTextField(
                  controller: titlecont,
                  label: "title kiriting",
                ),
                const SizedBox(
                  height: 5,
                ),
                MyTextField(
                  controller: pricecont,
                  label: "price kiriting",
                ),
                const SizedBox(
                  height: 5,
                ),
                MyTextField(
                  controller: descriptioncont,
                  label: "description kiriting",
                ),
                const SizedBox(
                  height: 5,
                ),
                MyTextField(
                    controller: categorycont, label: "categoriya kiriting"),
                const SizedBox(
                  height: 5,
                ),
                MyTextField(
                  controller: imagecont,
                  label: "imagePath kiriting",
                ),
                const SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                  onPressed: () async {
                    ProductsModel newProduct = ProductsModel(
                      title: titlecont.text,
                      price: double.parse(pricecont.text),
                      description: descriptioncont.text,
                      category: categorycont.text,
                      image: imagecont.text,
                    );
                    final dataa =
                        await AllProductsRepository.addProducts(newProduct);
                    final data = dataa[0];
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.green,
                        content: Column(
                          children: [
                            Text(
                                "Mahsulot :  ${data.title} nomida, ${data.id} id da magazinga qo'shildi!")
                          ],
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    "Add Product",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
