import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/services/repository/all_products_repo.dart';
import 'package:e_commerce/ui/details_page/widgets/appbarIcons.dart';
import 'package:e_commerce/ui/details_page/widgets/listview.dart';
import 'package:e_commerce/ui/home_page/widgets/textfield.dart';
import 'package:flutter/material.dart';

import '../../services/models/product_model/products_model.dart';

// ignore: must_be_immutable
class DetailsPage extends StatefulWidget {
  int? id;
  DetailsPage({super.key, required this.id});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  ProductsModel? data;
  TextEditingController titlecont = TextEditingController();
  TextEditingController pricecont = TextEditingController();
  TextEditingController desccont = TextEditingController();
  TextEditingController imagecont = TextEditingController();
  TextEditingController catcont = TextEditingController();
  d() async {
    final daa =
        await AllProductsRepository.fetchProductsByID(widget.id!.toInt());
    print(daa);
    setState(() {
      data = daa[0];
    });
    print(data);
  }

  @override
  void initState() {
    d();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
        actions: [
          AppbarIcons(
              titlecont: titlecont,
              data: data,
              pricecont: pricecont,
              desccont: desccont,
              imagecont: imagecont,
              catcont: catcont,
              widget: widget),
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
                          
                          final deleted =
                              await AllProductsRepository.deleteProductByID(
                                  widget.id!.toInt());
                          final d = deleted[0];
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Container(
                                child: Column(
                                  children: [
                                    Text(
                                        "${d.title} Nomli mahsulot muvaffaqiyatli o'chirildi!"),
                                  ],
                                ),
                              ),
                            ),
                          );
                          Navigator.pop(context);
                          
                          
                          
                          
                        },
                        child: Text(
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
