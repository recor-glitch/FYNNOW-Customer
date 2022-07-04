import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/Bloc%20Provider/address/cubit/address_cubit.dart';
import 'package:myapp/Bloc%20Provider/cart/cart_cubit.dart';
import 'package:myapp/Bloc%20Provider/category/category_cubit.dart';
import 'package:myapp/Bloc%20Provider/connectioncheck/connectioncheck_cubit.dart';
import 'package:myapp/Bloc%20Provider/order/order_cubit.dart';
import 'package:myapp/Bloc%20Provider/otp/otpverification_cubit.dart';
import 'package:myapp/Bloc%20Provider/product_detail/quantity_cubit.dart';
import 'package:myapp/Bloc%20Provider/profile/profile_cubit.dart';
import 'package:myapp/Bloc%20Provider/search/search_cubit.dart';
import 'package:myapp/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MainMaterial());
}

class MainMaterial extends StatelessWidget {
  MainMaterial({Key? key}) : super(key: key);

  AutoRouter router = AutoRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) =>
                  ConnectioncheckCubit(connectivity: Connectivity())),
          BlocProvider(create: (_) => CategoryCubit(), lazy: true),
          BlocProvider(create: (_) => QuantityCubit(), lazy: true),
          BlocProvider(create: (_) => SearchCubit(), lazy: true),
          BlocProvider(create: (_) => CartCubit(), lazy: true),
          BlocProvider(create: (_) => AddressCubit(), lazy: true),
          BlocProvider(create: (_) => ProfileCubit(), lazy: true),
          BlocProvider(create: (_) => OrderCubit(), lazy: true),
          BlocProvider(create: (_) => OtpverificationCubit())
        ],
        child: MaterialApp(
            onGenerateRoute: router.onGeneratedRoute,
            debugShowCheckedModeBanner: false));
  }
}
