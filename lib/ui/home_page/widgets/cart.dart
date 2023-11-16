import 'package:e_commerce/db_bloc/db_bloc.dart';
import 'package:e_commerce/services/models/my_cart_model.dart';
import 'package:e_commerce/services/models/product_model/products_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key, required this.products});
  final ProductsModel products;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DbBloc, DbState>(
      builder: (context, state) {
        return Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    if (!state.carts.any(
                      (cart) => cart.orderName == products.title,
                    )) {
                      context.read<DbBloc>().add(
                            InsertOrder(
                              cart: MyCartModel(
                                createdAt: DateTime.now().toString(),
                                price: products.price.toString(),
                                quantity: "1",
                                orderName: products.title,
                                originalPrice: products.price.toString(),
                              ),
                            ),
                          );
                    } else {
                      context
                          .read<DbBloc>()
                          .add(DeleteOrdersByName(orderName: products.title));
                    }
                  },
                  splashColor: Colors.transparent,
                  icon: Icon(
                    state.carts.any((cart) => cart.orderName == products.title)
                        ? Icons.shopping_cart_rounded
                        : Icons.shopping_cart_outlined,
                    color: Colors.red[300],
                  ),
                ),
                Text(products.rating!.count.toString(), style: TextStyle(color: Colors.red[300]),)
              ],
            ),
          ),
        );
      },
    );
  }
}
