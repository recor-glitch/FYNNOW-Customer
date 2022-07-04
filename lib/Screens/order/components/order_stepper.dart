import 'package:flutter/material.dart';

class OrderStepper extends StatefulWidget {
  final order;
  const OrderStepper({Key? key, this.order}) : super(key: key);

  @override
  State<OrderStepper> createState() => _OrderStepperState();
}

class _OrderStepperState extends State<OrderStepper> {
  @override
  Widget build(BuildContext context) {
    
    Widget OrderStatusCard(String status) {
      return ListTile(
        leading: CircleAvatar(
            backgroundColor: Colors.blue, child: Icon(Icons.check), radius: 15),
        title: Text(status),
      );
    }

    return Wrap(children: [
      OrderStatusCard('Order Confirmed'),
      Container(
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.075),
        color: Colors.grey,
        height: 20,
        width: 2,
      ),
      OrderStatusCard(widget.order['status'])
    ]);
  }
}
