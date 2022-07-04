import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/Infrastructure/cartfcade.dart';
import 'package:myapp/Models/productmodel.dart';

part 'selectattribute_state.dart';

class SelectattributeCubit extends Cubit<SelectattributeState> {
  CartProductModel product;
  String attribute;
  SelectattributeCubit(this.product, this.attribute)
      : super(SelectattributeLoading()) {
    emit(SelectattributeInitial(
        product.size, GetIndexOfAttribute(product, attribute)));
  }

  void OnClick(int index, String attribute) {
    if (attribute.contains('Size')) {
      emit(SelectattributeInitial(product.sizes[index], index));
    } else {
      emit(SelectattributeInitial(product.quantity, index));
    }
  }

  int GetIndexOfAttribute(CartProductModel product, String attribute) {
    if (attribute.contains('Size')) {
      return product.sizes.indexWhere((element) => element == product.size);
    } else {
      return product.quantity - 1;
    }
  }

  Future<void> UpdateCartAttribute(
      int index, String attribute, dynamic value) async {
    CartFcade fcade = CartFcade();
    await fcade.UpdateCartData(index, attribute, value);
  }
}
