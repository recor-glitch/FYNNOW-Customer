part of 'selectattribute_cubit.dart';

@immutable
abstract class SelectattributeState {}

class SelectattributeInitial extends SelectattributeState {
  final attribute;
  final int index;
  SelectattributeInitial(this.attribute, this.index);
}

class SelectattributeLoading extends SelectattributeState {}
