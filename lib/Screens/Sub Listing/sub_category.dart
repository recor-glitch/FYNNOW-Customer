import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/Components/customAppBar.dart';

class SubCategory extends StatelessWidget {
  const SubCategory({Key? key, required this.doc}) : super(key: key);
  final DocumentSnapshot doc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
          child: CustomAppBar(ispress: true)),
      backgroundColor: const Color.fromRGBO(243, 243, 243, 1),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: doc.get('subcategory').length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade300)),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: ListTile(
                          leading: CircleAvatar(
                              radius: 30,
                              backgroundImage: CachedNetworkImageProvider(
                                  doc.get('subcategory')[index]['img'])),
                          onTap: () {
                            Navigator.pushNamed(context, '/productlisting',
                                arguments: doc.get('Sub_Category')[
                                    doc.get('subcategory')[index]['Name']]);
                          },
                          title: Text(doc.get('subcategory')[index]['Name']),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          MaterialButton(
              onPressed: () {
                List data = [];
                doc.get('subcategory').forEach((sub) {
                  data += doc.get('Sub_Category')[sub['Name']];
                });
                Navigator.pushNamed(context, '/productlisting',
                    arguments: data);
              },
              child: Text('View All', style: GoogleFonts.roboto()))
        ]),
      )),
    );
  }
}
