import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/Infrastructure/cartfcade.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartLoading()) {
    FirebaseFirestore.instance
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((doc) {
      if (doc.exists && doc.get('products').isNotEmpty) {
        emit(CartHasData(doc.get('products')));
      } else {
        emit(CartEmpty());
      }
    });
  }

  Future<void> RemoveProduct(int index) async {
    emit(CartLoading());
    CartFcade fcade = CartFcade();
    fcade.RemoveFromCart(index);
  }
}
