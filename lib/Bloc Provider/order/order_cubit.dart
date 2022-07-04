import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderLoading()) {
    FirebaseFirestore.instance
        .collection('order')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((event) {
      if (event.exists && event.get('orders').isNotEmpty) {
        emit(OrderLoaded(event.get('orders')));
      } else {
        emit(OrderEmpty());
      }
    });
  }
}
