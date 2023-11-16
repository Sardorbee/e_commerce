import 'package:e_commerce/services/local/local_db.dart';
import 'package:e_commerce/services/models/my_cart_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'db_event.dart';
part 'db_state.dart';

class DbBloc extends Bloc<DbEvent, DbState> {
  DbBloc() : super(DbState(carts: [])) {
    on<GetAllOrders>(getAllOrders);
    on<InsertOrder>(insertOrders);
    on<DeleteOrders>(deleteOrders);
    on<DeleteAllOrders>(deleteAllOrders);
    on<UpdatePrice>(updatePrice);

    add(GetAllOrders());
  }

  getAllOrders(GetAllOrders event, Emitter<DbState> emit) async {
    emit(state.copyWith(
      carts: await LocalDatabase.getAllOrders(),
    ));
  }

  insertOrders(InsertOrder event, Emitter<DbState> emit) async {
    await LocalDatabase.insertOrder(event.cart);
    add(GetAllOrders());
  }

  updatePrice(UpdatePrice event, Emitter<DbState> emit) async {
    await LocalDatabase.updateOrderPrice(
        newQuantity: event.newQuantity,
        newPrice: event.newPrice,
        orderId: event.orderId);
    add(GetAllOrders());
  }

  deleteOrders(DeleteOrders event, Emitter<DbState> emit) async {
    await LocalDatabase.deleteOrderByID(event.id);
    add(GetAllOrders());
  }

  deleteAllOrders(DeleteAllOrders event, Emitter<DbState> emit) async {
    await LocalDatabase.deleteAllOrders();
    add(GetAllOrders());
  }
}
