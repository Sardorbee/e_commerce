part of 'db_bloc.dart';

@immutable
abstract class DbEvent {}

class InsertOrder extends DbEvent {
  final MyCartModel cart;
  InsertOrder({required this.cart});
}

class GetAllOrders extends DbEvent {}

class UpdatePrice extends DbEvent {
  final int orderId;
  final String newPrice;
  final String newQuantity;
  UpdatePrice(
      {required this.orderId,
      required this.newPrice,
      required this.newQuantity});
}

class DeleteOrders extends DbEvent {
  final int id;
  DeleteOrders({required this.id});
}

class DeleteAllOrders extends DbEvent {}
