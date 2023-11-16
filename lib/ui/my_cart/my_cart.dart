import 'package:e_commerce/db_bloc/db_bloc.dart';
import 'package:e_commerce/services/models/my_cart_model.dart';
import 'package:e_commerce/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyCart extends StatelessWidget {
  const MyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBg,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.mainBg,
        title: const Text("My Cart"),
        actions: [
          IconButton(
              onPressed: () {
                context.read<DbBloc>().add(DeleteAllOrders());
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ))
        ],
      ),
      body: BlocBuilder<DbBloc, DbState>(
        builder: (context, state) {
          if (state.carts.isEmpty) {
            return const Center(
              child: Text(
                "You don't have any orders yet",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            );
          }
          return ListView(children: [
            ...List.generate(state.carts.length, (index) {
              MyCartModel cart = state.carts[index];

              return ListTile(
                title: Text(
                  cart.orderName,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
                subtitle: Text(
                  "${cart.price} \$",
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        int newQuantity = int.parse(cart.quantity) - 1;
                        if (newQuantity >= 0) {
                          double newPrice = double.parse(cart.price) -
                              double.parse(cart.originalPrice);
                          context.read<DbBloc>().add(
                                UpdatePrice(
                                  orderId: cart.id!,
                                  newPrice: newPrice.toStringAsFixed(
                                      2), // Assuming you want to keep two decimal places
                                  newQuantity: newQuantity.toString(),
                                ),
                              );
                        }
                      },
                      child: const Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      cart.quantity,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    const SizedBox(width: 5),
                    InkWell(
                      onTap: () {
                        int newQuantity = int.parse(cart.quantity) + 1;
                        double newPrice = double.parse(cart.price) +
                            double.parse(cart.originalPrice);

                        context.read<DbBloc>().add(
                              UpdatePrice(
                                orderId: cart.id!,
                                newPrice: newPrice.toStringAsFixed(2),
                                newQuantity: newQuantity.toString(),
                              ),
                            );
                      },
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              );
            })
          ]);
        },
      ),
    );
  }
}
