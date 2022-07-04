part of 'cart_cubit.dart';

@immutable
abstract class CartState {}

class CartLoading extends CartState {}

class CartHasData extends CartState {
  final products;
  CartHasData(this.products);
}

class CartEmpty extends CartState {}
