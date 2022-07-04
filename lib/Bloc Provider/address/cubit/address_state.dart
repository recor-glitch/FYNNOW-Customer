part of 'address_cubit.dart';

@immutable
abstract class AddressState {}

class AddressLoading extends AddressState {}

class AddressEmpty extends AddressState {}

class AddressLoaded extends AddressState {
  final List address;
  AddressLoaded(this.address);
}
