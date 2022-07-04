import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import 'package:cashfree_pg/cashfree_pg.dart';

Future<Either<Map, bool>> ProceedPayment(
    {required int phn, required String email, required double price, required String orderid}) async {

  http.Response res = await http.post(
      Uri.parse("https://api.cashfree.com/api/v2/cftoken/order"),
      headers: {
        "x-client-id": "2013127d349aac32afd57ed107213102",
        "x-client-secret": "bc02b7314ba456e1028ae6a2d469b6db9721ae24",
      },
      body: json.encode({
        "orderId": orderid,
        "orderAmount": price,
        "orderCurrency": "INR",
      }));

  if (res.statusCode == 200) {
    var map = json.decode(res.body) as Map;

    Map<String, dynamic> inputs = {
      "orderId": orderid,
      "orderAmount": price,
      "orderCurrency": 'INR',
      "appId": '2013127d349aac32afd57ed107213102',
      "customerPhone": phn,
      "customerEmail": email,
      "stage": 'PROD',
      "tokenData": map['cftoken'],
    };

    var value = await CashfreePGSDK.doPayment(inputs) as Map;
    return Left(value);
  } else {
    return Right(false);
  }
}
