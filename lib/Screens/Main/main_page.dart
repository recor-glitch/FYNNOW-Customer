import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Components/customBottom.dart';
import 'package:myapp/Screens/Cart/cart.dart';
import 'package:myapp/Screens/Category/category_list_page.dart';
import 'package:myapp/Screens/Checkout/checkout.dart';
import 'package:myapp/Screens/Detail/detail.dart';
import 'package:myapp/Screens/FAQ/faq_page.dart';
import 'package:myapp/Screens/Home/home_page.dart';
import 'package:myapp/Screens/Product%20Listing/product_listing.dart';
import 'package:myapp/Screens/Profile/profile_page.dart';
import 'package:myapp/Screens/Sub%20Listing/sub_category.dart';
import 'package:myapp/Screens/address/address.dart';
import 'package:myapp/Screens/order/orderdetail.dart';
import 'package:myapp/Screens/order/orderspage.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with TickerProviderStateMixin<MainPage> {
  late TabController controller;
  final navigatorkey1 = GlobalKey<NavigatorState>();
  final navigatorkey2 = GlobalKey<NavigatorState>();
  final navigatorkey3 = GlobalKey<NavigatorState>();
  final navigatorkey4 = GlobalKey<NavigatorState>();

  @override
  void initState() {
    controller = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(243, 243, 243, 1),
        body: TabBarView(controller: controller, children: [
          WillPopScope(
            onWillPop: () {
              if (navigatorkey1.currentState!.canPop()) {
                navigatorkey1.currentState!.maybePop();
                return Future.value(false);
              }
              return Future.value(true);
            },
            child: Navigator(
              key: navigatorkey1,
              onGenerateRoute: (RouteSettings setting) {
                switch (setting.name) {
                  case '/':
                    return MaterialPageRoute(builder: (_) => HomePage());
                  case '/detail':
                    var product = setting.arguments as Map;
                    return MaterialPageRoute(
                        builder: (_) => DetailPage(product: product));
                  case '/sublist':
                    var doc = setting.arguments as DocumentSnapshot;
                    return MaterialPageRoute(
                        builder: (_) => SubCategory(doc: doc));
                  case '/productlisting':
                    var products = setting.arguments as List;
                    return MaterialPageRoute(
                        builder: (_) => ProductListing(products: products));
                  case '/address':
                    return MaterialPageRoute(builder: (_) => AddAddress());
                  case '/checkout':
                    var products = setting.arguments as List;
                    return MaterialPageRoute(
                        builder: (_) => CheckOut(products: products));
                  default:
                    return MaterialPageRoute(builder: (_) => HomePage());
                }
              },
            ),
          ),
          WillPopScope(
            onWillPop: () {
              if (navigatorkey2.currentState!.canPop()) {
                navigatorkey2.currentState!.maybePop();
                return Future.value(false);
              } else {
                controller.animateTo(0);
                return Future.value(false);
              }
            },
            child: Navigator(
              key: navigatorkey2,
              onGenerateRoute: (RouteSettings setting) {
                switch (setting.name) {
                  case '/':
                    return MaterialPageRoute(
                        builder: (_) => CategoryListPage());
                  case '/detail':
                    var product = setting.arguments as Map;
                    return MaterialPageRoute(
                        builder: (_) => DetailPage(product: product));
                  case '/sublist':
                    var doc = setting.arguments as DocumentSnapshot;
                    return MaterialPageRoute(
                        builder: (_) => SubCategory(doc: doc));
                  case '/productlisting':
                    var products = setting.arguments as List;
                    return MaterialPageRoute(
                        builder: (_) => ProductListing(products: products));
                  default:
                    return MaterialPageRoute(
                        builder: (_) => CategoryListPage());
                }
              },
            ),
          ),
          WillPopScope(
            onWillPop: () {
              if (navigatorkey3.currentState!.canPop()) {
                navigatorkey3.currentState!.maybePop();
                return Future.value(false);
              } else {
                controller.animateTo(0);
                return Future.value(false);
              }
            },
            child: Navigator(
              key: navigatorkey3,
              onGenerateRoute: (RouteSettings setting) {
                switch (setting.name) {
                  case '/':
                    return MaterialPageRoute(builder: (_) => Cart());
                  case '/detail':
                    var product = setting.arguments as Map;
                    return MaterialPageRoute(
                        builder: (_) => DetailPage(product: product));
                  case '/address':
                    return MaterialPageRoute(builder: (_) => AddAddress());
                  case '/checkout':
                    var products = setting.arguments as List;
                    return MaterialPageRoute(
                        builder: (_) => CheckOut(products: products));
                  default:
                    return MaterialPageRoute(builder: (_) => Cart());
                }
              },
            ),
          ),
          WillPopScope(
            onWillPop: () {
              if (navigatorkey4.currentState!.canPop()) {
                navigatorkey4.currentState!.maybePop();
                return Future.value(false);
              } else {
                controller.animateTo(0);
                return Future.value(false);
              }
            },
            child: Navigator(
              key: navigatorkey4,
              onGenerateRoute: (RouteSettings setting) {
                switch (setting.name) {
                  case '/':
                    return MaterialPageRoute(builder: (_) => ProfilePage());
                  case '/order':
                    return MaterialPageRoute(builder: (_) => OrderPage());
                  case '/orderdetail':
                    var order = setting.arguments as Map;
                    return MaterialPageRoute(
                        builder: (_) => OrderDetail(order: order));
                  case '/faq':
                    return MaterialPageRoute(builder: (_) => FaqPage());
                  default:
                    return MaterialPageRoute(builder: (_) => ProfilePage());
                }
              },
            ),
          )
        ]),
        bottomNavigationBar: CustomBottomNavigationBar(controller: controller),
      ),
    );
  }
}
