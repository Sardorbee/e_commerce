import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/services/apis/all_products.dart';
import 'package:flutter/material.dart';

import '../../../services/models/product_model/products_model.dart';
import '../../../services/repository/all_products_repo.dart';
import '../details_page.dart';

class ListviewFuture extends StatelessWidget {
  
   ListviewFuture({
    super.key,
    required this.widget,
    
  });
 

  final DetailsPage widget;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        FutureBuilder(
          future: AllProductsRepository(aPiProvider: APiProvider()).fetchProductsByID(widget.id!.toInt()),
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

            final List<ProductsModel> dataa = snapshot.data;
            final data = dataa[0];

            return Column(
              mainAxisSize: MainAxisSize.min,
              // crossAxisAlignment: CrossAxisAlignment.star?t,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CachedNetworkImage(height: 360, imageUrl: data.image),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        data.title,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                    Text(
                      "${data.price.toString()} \$",
                      style: const TextStyle(fontSize: 24),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber[600],
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          data.rating!.rate.toString(),
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.amber[600],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.download,
                          color: Colors.green,
                        ),
                        Text(
                          data.rating!.count.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Description",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Flexible(
                  child: Text(
                    data.description,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
