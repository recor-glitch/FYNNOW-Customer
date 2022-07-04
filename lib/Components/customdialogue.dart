import 'package:flutter/material.dart';
import 'package:myapp/Screens/Detail/components/customcontainer.dart';

Future CustomDialogue(Map order, BuildContext context, String orderid) {
  return showDialog(
      context: context,
      builder: (BuildContext custom_context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Image(
                          image: order['txStatus'] == 'SUCCESS'
                              ? AssetImage('assets/ordersuccess.png')
                              : AssetImage('assets/orderfail.png'))),
                  Text('Your Order is ${order['txStatus']}'),
                  Text('Order Id: $orderid'),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: CustomContainer(
                        press: () =>
                            Navigator.pushReplacementNamed(custom_context, '/'),
                        value: 'Continue Shopping',
                        colour: Colors.white,
                        style: TextStyle(color: Color.fromRGBO(226, 51, 72, 1)),
                        border: BorderSide(
                            color: Color.fromRGBO(226, 51, 72, 1), width: 1)),
                  )
                ]),
          ),
        );
      });
}
