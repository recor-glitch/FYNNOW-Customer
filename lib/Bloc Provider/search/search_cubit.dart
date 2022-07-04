import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  List data = [];
  SearchCubit() : super(SearchLoading()) {
    FirebaseFirestore.instance
        .collection('CategoryList')
        .snapshots()
        .listen((snap) {
      snap.docs.forEach((element) {
        element.get('subcategory').forEach((sub) {
          element.get('Sub_Category')[sub['Name']].forEach((product) {
            data.add(product['Name'].toLowerCase());
          });
        });
      });
    });
  }

  void GetSearchResult(String query) {
    List queryresult = [];
    if (query.isNotEmpty) {
      data.forEach((element) {
        if (element.contains(query.toLowerCase())) {
          queryresult.add(element);
        }
      });
      if (queryresult.isNotEmpty) {
        emit(SearchLoaded(products: queryresult));
      } else {
        emit(SearchLoaded(products: ['No Products Found!']));
      }
    } else {
      emit(SearchLoading());
    }
  }
}
