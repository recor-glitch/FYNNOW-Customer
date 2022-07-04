import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/Bloc%20Provider/address/cubit/address_cubit.dart';
import 'package:myapp/Components/custom_alert.dart';
import 'package:myapp/Components/customdialogue.dart';
import 'package:myapp/Infrastructure/orderfacade.dart';
import 'package:myapp/Infrastructure/payment.dart';
import 'package:myapp/Models/productmodel.dart';
import 'package:intl/intl.dart';

class Body extends StatefulWidget {
  final List products;
  Body({Key? key, required this.products}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int groupval = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget AddressCard(String addresstype, String address, int value) {
      return Card(
        child: ListTile(
            leading: Radio(
                value: value,
                groupValue: groupval,
                onChanged: (int? value) {
                  setState(() {
                    groupval = value as int;
                  });
                }),
            title: Text(addresstype),
            subtitle: Text(address),
            trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => BlocProvider.of<AddressCubit>(context)
                    .RemoveAddress(value))),
      );
    }

    Widget DeliveryAddress() {
      return Wrap(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                child:
                    Text('Delivery Address', style: TextStyle(fontSize: 20))),
            Flexible(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: ListTile(
                  leading: Icon(Icons.add, size: 30, color: Colors.blue),
                  title: Text('Add', style: TextStyle(color: Colors.blue)),
                  onTap: () {
                    Navigator.pushNamed(context, '/address');
                  },
                ),
              ),
            )
          ],
        ),
        BlocBuilder<AddressCubit, AddressState>(
          builder: (context, state) {
            if (state is AddressLoaded) {
              return Wrap(children: [
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.address.length,
                    itemBuilder: (BuildContext context, int index) {
                      return AddressCard(state.address[index]['address_type'],
                          state.address[index]['address'], index);
                    }),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        child: Text('CONTINUE'),
                        onPressed: () {
                          double price = 0;

                          widget.products.forEach((element) {
                            price = double.parse(element['price']) *
                                    element['quantity'] +
                                price;
                          });
                          var orderid =
                              'FYNNOWORDER${DateTime.now().microsecondsSinceEpoch}';
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext modal_context) {
                                return Wrap(
                                  children: [
                                    ListTile(
                                        title: Text('Payment Modes:',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20))),
                                    ListTile(
                                        leading: Icon(Icons.handshake),
                                        title: Text('COD'),
                                        onTap: () async {
                                          Navigator.pop(modal_context);
                                          await CustomAlert(context, () {
                                            OrderFacade facade = OrderFacade();
                                            facade.CollectOrder(OrderProductModel(
                                                widget.products,
                                                DateFormat(
                                                        'yyyy-MM-dd HH:mm:ss')
                                                    .format(DateTime.now())
                                                    .toString(),
                                                orderid,
                                                'CONFIRMED',
                                                'COD',
                                                'Rajo Store',
                                                price.toString(),
                                                state.address[groupval]));
                                            CustomDialogue(
                                                {'txStatus': 'SUCCESS'},
                                                context,
                                                orderid);
                                          }, 'Are you sure?',
                                              'Want to continue with the order?');
                                        }),
                                    ListTile(
                                        leading: Icon(Icons.online_prediction),
                                        title: Text('Online Payment'),
                                        onTap: () async {
                                          Navigator.pop(modal_context);
                                          ProceedPayment(
                                                  orderid: orderid,
                                                  phn: int.parse(
                                                      state.address[groupval]
                                                          ['mobile']),
                                                  email: state.address[groupval]
                                                      ['email'],
                                                  price: price)
                                              .then((result) {
                                            if (result.isLeft) {
                                              if (result.left['txStatus']
                                                  .contains('CANCELLED')) {
                                                widget.products
                                                    .forEach((product) {
                                                  OrderFacade facade =
                                                      OrderFacade();
                                                  facade.CollectOrder(
                                                      OrderProductModel(
                                                          product,
                                                          DateFormat(
                                                                  'yyyy-MM-dd HH:mm:ss')
                                                              .format(DateTime
                                                                  .now())
                                                              .toString(),
                                                          orderid,
                                                          result
                                                              .left['txStatus'],
                                                          'NULL',
                                                          'Rajo Store',
                                                          price.toString(),
                                                          state.address[
                                                              groupval]));
                                                });
                                                CustomDialogue(result.left,
                                                    context, orderid);
                                              } else if (result.left['txStatus']
                                                  .contains('SUCCESS')) {
                                                OrderFacade facade =
                                                    OrderFacade();
                                                widget.products.forEach((product) =>
                                                    facade.CollectOrder(
                                                        OrderProductModel(
                                                            product,
                                                            DateFormat(
                                                                    'yyyy-MM-dd HH:mm:ss')
                                                                .format(DateTime
                                                                    .now())
                                                                .toString(),
                                                            orderid,
                                                            result.left[
                                                                'txStatus'],
                                                            'ONLINE',
                                                            'Rajo Store',
                                                            price.toString(),
                                                            state.address[
                                                                groupval])));
                                                CustomDialogue(result.left,
                                                    context, orderid);
                                              }
                                            }
                                          });
                                        })
                                  ],
                                );
                              });
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(226, 51, 72, 1))))
              ]);
            } else {
              return Center(
                  child: TextButton(
                      child: Text('Add New Address'),
                      onPressed: () {
                        Navigator.pushNamed(context, '/address');
                      }));
            }
          },
        )
      ]);
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DeliveryAddress(),
          ],
        ),
      ),
    );
  }
}
