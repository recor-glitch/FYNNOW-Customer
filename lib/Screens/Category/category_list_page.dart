import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/Bloc%20Provider/category/category_cubit.dart';
import 'package:myapp/Components/customAppBar.dart';
import 'package:myapp/Screens/Home/components/custom_category_card.dart';

class CategoryListPage extends StatefulWidget {
  @override
  _CategoryListPageState createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
            child: CustomAppBar(ispress: false)),
        backgroundColor: Colors.grey.shade200,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Text(
                    'Category List',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.roboto(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: BlocBuilder<CategoryCubit, CategoryState>(
                  builder: (context, state) {
                    if (state is CategoryLoaded) {
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: GridView.builder(
                            shrinkWrap: true,
                            itemCount: state.snap.size,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10),
                            itemBuilder: (BuildContext context, int index) {
                              return CustomCategoryCard(
                                  name: state.snap.docs[index].get('category'),
                                  img: state.snap.docs[index].get('img'),
                                  press: () {
                                    Navigator.pushNamed(context, '/sublist',
                                        arguments: state.snap.docs[index]);
                                  });
                            }),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
