import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/Models/productmodel.dart';

class OrderFacade {
  Future<void> CollectOrder(OrderProductModel order) async {
    FirebaseFirestore.instance
        .collection('order')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snap) async {
      if (snap.get('orders').isNotEmpty) {
        var data = snap.get('orders') as List;
        order.products.forEach((product) {
          data.add({
            'orderid': order.orderid,
            'userid': FirebaseAuth.instance.currentUser!.uid,
            'time': order.time,
            'status': order.status,
            'product': product,
            'amount': order.amount,
            'payment': order.payment,
            'seller': order.seller,
            'address': order.address,
            'size': order.products.length
          });
        });
        await FirebaseFirestore.instance
            .collection('order')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'orders': data});
      } else {
        List data = [];
        order.products.forEach((product) {
          data.add({
            'orderid': order.orderid,
            'userid': FirebaseAuth.instance.currentUser!.uid,
            'time': order.time,
            'status': order.status,
            'product': product,
            'amount': order.amount,
            'payment': order.payment,
            'seller': order.seller,
            'address': order.address,
            'size': order.products.length
          });
        });

        await FirebaseFirestore.instance
            .collection('order')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'orders': data});
      }
    });
  }
}
