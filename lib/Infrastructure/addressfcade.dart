import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/Models/addressmodel.dart';

class addressfcade {
  Future<void> SaveAddress(addressmodel address) async {
    List data = [];
    FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((doc) {
      if (doc.exists) {
        if (doc.get('address').isNotEmpty) {
          data = doc.get('address');
          data.add({
            'name': address.name,
            'address': address.address,
            'city': address.city,
            'address_type': address.address_type,
            'email': address.email,
            'locality': address.locality,
            'pincode': address.pincode,
            'mobile': address.mobile,
            'state': address.state
          });
          FirebaseFirestore.instance
              .collection('user')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update({'address': data});
        } else {
          data.add({
            'name': address.name,
            'address': address.address,
            'city': address.city,
            'address_type': address.address_type,
            'email': address.email,
            'locality': address.locality,
            'pincode': address.pincode,
            'mobile': address.mobile,
            'state': address.state
          });
          FirebaseFirestore.instance
              .collection('user')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update({'address': data});
        }
      }
    });
  }

  Future<void> RemoveAddress(int index) async {
    FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((doc) async {
      if (doc.get('address').isNotEmpty) {
        var data = doc.get('address') as List;

        data.removeAt(index);
        await FirebaseFirestore.instance
            .collection('user')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'address': data});
      }
    });
  }
}
