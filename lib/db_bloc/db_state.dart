part of 'db_bloc.dart';

class DbState {
  final List<MyCartModel> carts;

  DbState({required this.carts});

  DbState copyWith({
    List<MyCartModel>? carts,
  }) {
    return DbState(
      carts: carts ?? this.carts,
    );
  }
}
