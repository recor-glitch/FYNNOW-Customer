part of 'order_cubit.dart';

@immutable
abstract class OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  List orders;
  OrderLoaded(this.orders);
}

class OrderEmpty extends OrderState {}
