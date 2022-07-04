import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/Infrastructure/addressfcade.dart';
import 'package:myapp/Models/addressmodel.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit() : super(AddressLoading()) {
    FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((doc) {
      if (doc.get('address').isNotEmpty) {
        emit(AddressLoaded(doc.get('address')));
      } else {
        emit(AddressEmpty());
      }
    });
  }

  Future<void> SaveAddress(addressmodel address) async {
    addressfcade fcade = addressfcade();
    await fcade.SaveAddress(address);
  }

  Future<void> RemoveAddress(int index) async {
    addressfcade fcade = addressfcade();
    await fcade.RemoveAddress(index);
  }
}
