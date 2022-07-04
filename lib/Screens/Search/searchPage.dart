import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/Bloc%20Provider/search/search_cubit.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchcontroller = TextEditingController();

  @override
  void dispose() {
    searchcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.1), child: Row(children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: searchcontroller,
              decoration: InputDecoration(
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                  hintText: 'Search for electronics, grocery etc...',
                  prefixIcon: Icon(Icons.search)),
              onChanged: (value) =>
                  BlocProvider.of<SearchCubit>(context).GetSearchResult(value),
            ),
          ),
        ),
        Icon(Icons.mic)
      ]),)),
    );
  }
}





// searching ...

// BlocBuilder<SearchCubit, SearchState>(
//                     builder: (BuildContext context, searchstate) {
//                   if (searchstate is SearchLoaded) {
//                     return ListView.builder(
//                         itemCount: searchstate.products.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           return Padding(
//                             padding: const EdgeInsets.all(10.0),
//                             child: Card(
//                               child: ListTile(
//                                 title: Text(searchstate.products[index]),
//                                 onTap: () async {
//                                   FirebaseFirestore.instance
//                                       .collection('CategoryList')
//                                       .snapshots()
//                                       .listen((snap) {
//                                     snap.docs.forEach((element) {
//                                       element.get('subcategory').forEach((sub) {
//                                         element
//                                             .get('Sub_Category')[sub['Name']]
//                                             .forEach((product) {
//                                           if (searchstate.products[index] ==
//                                               product['Name'].toLowerCase()) {
//                                             Navigator.pushNamed(
//                                                 context, '/detail',
//                                                 arguments: product);
//                                           }
//                                         });
//                                       });
//                                     });
//                                   });
//                                 },
//                               ),
//                             ),
//                           );
//                         });
//                   } 
//                 })