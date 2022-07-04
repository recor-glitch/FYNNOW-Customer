import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/Bloc%20Provider/order/order_cubit.dart';
import 'package:myapp/Components/customAppBar.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget CustomOrderCard(Map order) {
      return GestureDetector(
        onTap: () =>
            Navigator.pushNamed(context, '/orderdetail', arguments: order),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Image(
                    image:
                        CachedNetworkImageProvider(order['product']['img'][0]),
                    height: 100,
                    width: 100),
                Expanded(
                  child: Wrap(
                    direction: Axis.vertical,
                    children: [
                      Text.rich(TextSpan(
                          text: order['status'],
                          style: TextStyle(
                              color: order['status'] == 'DELIVERED'
                                  ? Colors.green
                                  : order['status'] == 'CANCELLED'
                                      ? Colors.red
                                      : Colors.green,
                              fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(text: ' ON'),
                            TextSpan(text: " ${order['time']}")
                          ])),
                      Text(order['product']['name'],
                          maxLines: 2, overflow: TextOverflow.ellipsis),
                      order['status'].contains('DELIVERED')
                          ? Row(
                              children: [
                                Icon(Icons.star, color: Colors.grey.shade300),
                                Icon(Icons.star, color: Colors.grey.shade300),
                                Icon(Icons.star, color: Colors.grey.shade300),
                                Icon(Icons.star, color: Colors.grey.shade300),
                                Icon(Icons.star, color: Colors.grey.shade300)
                              ],
                            )
                          : Container(),
                      order['status'].contains('DELIVERED')
                          ? const Text('Rate this Product now',
                              maxLines: 1, overflow: TextOverflow.ellipsis)
                          : Container()
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    return SafeArea(
        child: Scaffold(
      backgroundColor: Color.fromRGBO(243, 243, 243, 1),
      appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
          child: CustomAppBar(ispress: true)),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: TextField(
                          decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.all(5),
                              hintText: 'Search your order here',
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)))),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text('Your Orders', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              ),
            ),
            BlocBuilder<OrderCubit, OrderState>(
                builder: (BuildContext context, state) {
              if (state is OrderLoaded) {
                return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.orders.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CustomOrderCard(state.orders[index]);
                    });
              } else if (state is OrderEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                          image: AssetImage('assets/noorder.png'),
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width * 0.8),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06),
                      Text('You have no Orders, \n go for shopping.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                );
              } else {
                return CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    child: CircularProgressIndicator());
              }
            })
          ],
        ),
      ),
    ));
  }
}
