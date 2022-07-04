import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/Bloc%20Provider/address/cubit/address_cubit.dart';
import 'package:myapp/Components/customAppBar.dart';
import 'package:myapp/Models/addressmodel.dart';
import 'package:myapp/Screens/address/components/customaddfield.dart';
import 'package:myapp/Screens/address/components/customdivider.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({Key? key}) : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  late TextEditingController name, mobile, pincode, address, locality, city;
  int groupval = 0;

  @override
  void initState() {
    name = TextEditingController();
    mobile = TextEditingController();
    pincode = TextEditingController();
    address = TextEditingController();
    locality = TextEditingController();
    city = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    name.dispose();
    mobile.dispose();
    pincode.dispose();
    address.dispose();
    locality.dispose();
    city.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
            child: CustomAppBar(ispress: true)),
        backgroundColor: Colors.grey.shade200,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Add New Address',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              CustomDivider(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              CustomAddressField(label: 'Name*', controller: name),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              CustomAddressField(label: 'Mobile*', controller: mobile),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              CustomDivider(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      child: CustomAddressField(
                          controller: pincode, label: 'Pincode*')),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                  const Expanded(
                      child: TextField(
                          decoration: InputDecoration(hintText: 'Assam*')))
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              CustomAddressField(
                  label: 'Address(House No. Building, Street, Area)*',
                  controller: address),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              CustomAddressField(label: 'Locality/Town*', controller: locality),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              CustomAddressField(label: 'City/District*', controller: city),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              CustomDivider(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Text('Type of Address *', style: TextStyle(fontSize: 18)),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Row(children: [
                Expanded(
                  child: RadioListTile(
                      value: 1,
                      groupValue: groupval,
                      onChanged: (int? value) {
                        setState(() {
                          groupval = value as int;
                        });
                      },
                      title: Text('Home')),
                ),
                Expanded(
                  child: RadioListTile(
                      value: 2,
                      groupValue: groupval,
                      onChanged: (int? value) {
                        setState(() {
                          groupval = value as int;
                        });
                      },
                      title: Text('Office')),
                )
              ]),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                          child: Text('CANCEL',
                              style: TextStyle(
                                  color: Color.fromRGBO(226, 51, 72, 1))),
                          onPressed: () => Navigator.pop(context),
                          style:
                              ElevatedButton.styleFrom(primary: Colors.white))),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                  Expanded(
                      child: ElevatedButton(
                          child: Text('SAVE',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            if (name.text != '' &&
                                address.text != '' &&
                                groupval != 0 &&
                                city.text != '' &&
                                locality.text != '' &&
                                mobile.text != '' &&
                                pincode.text != '') {
                              BlocProvider.of<AddressCubit>(context)
                                  .SaveAddress(addressmodel(
                                      name: name.text,
                                      address: address.text,
                                      city: city.text,
                                      address_type:
                                          groupval == 1 ? 'Home' : 'Office',
                                      email: FirebaseAuth
                                          .instance.currentUser!.email
                                          .toString(),
                                      locality: locality.text,
                                      pincode: pincode.text,
                                      mobile: mobile.text,
                                      state: 'Assam'));
                              Navigator.pop(context);
                            } else {
                              print('All the Fields are required.');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromRGBO(226, 51, 72, 1))))
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
