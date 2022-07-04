import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartFcade {
  Future<void> AddToCart(Map product) async {
    var data;
    bool already_there = false;
    FirebaseFirestore.instance
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((doc) async {
      if (doc.exists) {
        data = doc.get('products') as List;
        data.forEach((element) {
          if (product['name'] == element['name'] && product['size'] == element['size']) {
            already_there = true;
          }
        });
        if (!already_there) {
          data.add(product);
          await FirebaseFirestore.instance
              .collection('cart')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update({'products': data});
        }
      } else {
        data = [product];
        await FirebaseFirestore.instance
            .collection('cart')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({'products': data});
      }
    });
  }

  Future<void> RemoveFromCart(int index) async {
    FirebaseFirestore.instance
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snap) async {
      if (snap.exists) {
        var data = snap.get('products') as List;
        data.removeAt(index);
        await FirebaseFirestore.instance
            .collection('cart')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'products': data});
      }
    });
  }

  Future<void> UpdateCartData(
      int index, String attribute, dynamic value) async {
    FirebaseFirestore.instance
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((doc) {
      if (doc.exists) {
        var data = doc.get('products') as List;

        var product = data[index];
        if (attribute.contains('Size')) {
          product['size'] = value;
        } else {
          product['quantity'] = value;
        }

        data.removeAt(index);
        data.insert(index, product);

        FirebaseFirestore.instance
            .collection('cart')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'products': data});
      }
    });
  }
}
