import 'package:flutter/material.dart';
import 'package:myapp/Components/customAppBar.dart';
import 'package:myapp/Screens/order/components/order_stepper.dart';

class OrderDetail extends StatelessWidget {
  final Map order;
  const OrderDetail({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget CustomPriceRow(String detail, String value, bool isbold) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(detail,
                style: TextStyle(fontWeight: isbold ? FontWeight.bold : null)),
            Text('₹ $value',
                style: TextStyle(fontWeight: isbold ? FontWeight.bold : null))
          ],
        ),
      );
    }

    Widget PriceDetail(Map item) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Price Details'),
                Divider(thickness: 1, color: Colors.grey.shade300),
                CustomPriceRow('Total MRP', item['price'], false),
                CustomPriceRow('Discount on MRP', '200', false),
                double.parse(item['price']) < 500
                    ? CustomPriceRow('Convenience Fee', '25', false)
                    : Container(),
                double.parse(item['price']) > 500
                    ? CustomPriceRow('Total Amount',
                        '${double.parse(item['price']) - 200}', false)
                    : CustomPriceRow('Total Amount',
                        '${double.parse(item['price']) - 200 + 25}', false),
              ],
            ),
          ),
        ),
      );
    }

    Widget ShippingDetail(Map address) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Shipping Details'),
              Divider(thickness: 1, color: Colors.grey.shade300),
              Text(address['name'], style: TextStyle(fontSize: 20)),
              Text(address['address']),
              Text(address['locality']),
              Text(address['city']),
              Text('${address['state']} - ${address['pincode']}'),
              Text('Phone number : ${address['mobile']}')
            ]),
          ),
        ),
      );
    }

    Widget ProductCard(Map pro) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(pro['name'], style: TextStyle(fontSize: 20)),
                    Row(
                      children: [
                        pro['size'] != null
                            ? Row(
                                children: [
                                  Text('Size : '),
                                  Text(pro['size']),
                                  Text(', '),
                                  Text('Quantity : ${pro['quantity']}')
                                ],
                              )
                            : Text('Quantity : ${pro['quantity']}'),
                        pro['color'] != null
                            ? Row(
                                children: [
                                  Text('Colour : '),
                                  Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Color.fromRGBO(
                                              pro['color']['r'],
                                              pro['color']['g'],
                                              pro['color']['b'],
                                              1)),
                                      height: 13,
                                      width: 13)
                                ],
                              )
                            : Container()
                      ],
                    ),
                    Text.rich(TextSpan(text: 'Seller : ', children: [
                      TextSpan(text: order['seller'].toString())
                    ])),
                    Text(
                      '₹ ${order['product']['price']}',
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                )),
                Image(
                    image: NetworkImage(pro['img'][0]), height: 100, width: 100)
              ],
            ),
            Divider(thickness: 1, color: Colors.grey.shade300)
          ],
        ),
      );
    }

    return Scaffold(
      appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
          child: CustomAppBar(ispress: true)),
      backgroundColor: Color.fromRGBO(243, 243, 243, 1),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
                child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text.rich(TextSpan(
                      text: 'Order ID - ',
                      children: [TextSpan(text: order['orderid'].toString())])),
                ),
                Divider(thickness: 1, color: Colors.grey.shade300),
                ProductCard(order['product']),
                OrderStepper(order: order),
                Divider(thickness: 1, color: Colors.grey.shade300),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: order['status'].contains('DELIVERED')
                        ? TextButton(
                            onPressed: () {},
                            child: Text(
                              'Need Help?',
                              style: TextStyle(color: Colors.grey),
                            ))
                        : Row(children: [
                            Expanded(
                                child: ElevatedButton(
                                    child: Text('Request Cancellation'),
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.grey.shade400))),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.02),
                            Expanded(
                                child: ElevatedButton(
                                    child: Text('Request Return'),
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.grey.shade400)))
                          ]),
                  ),
                )
              ],
            )),
            ShippingDetail(order['address'] as Map),
            PriceDetail(order['product']),
            SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Card(
                    child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('${order['payment']} (items: ${order['size']}) : ₹${order['amount']}'),
                )))
          ],
        ),
      )),
    );
  }
}
