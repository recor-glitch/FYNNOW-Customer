class ProductModel {
  ProductModel(
      {required this.price,
      required this.name,
      required this.img,
      required this.desc,
      required this.brand,
      required this.sizes,
      required this.colours});
  final String price;
  final String brand;
  final String desc;
  final String name;
  final List img;
  final List sizes;
  final List colours;
}

class CartProductModel {
  CartProductModel(
      {required this.price,
      required this.name,
      required this.img,
      required this.desc,
      required this.brand,
      required this.sizes,
      required this.size,
      required this.colour,
      required this.quantity,
      required this.colours});
  final String price, brand, desc, name;
  final List img;
  final List sizes;
  final dynamic size;
  final int quantity;
  final dynamic colour;
  final List colours;
}

class OrderProductModel {
  OrderProductModel(this.products, this.time, this.orderid, this.status,
      this.payment, this.seller, this.amount, this.address);
  final List products;
  final String time;
  final String orderid;
  final String status;
  final String payment;
  final String seller;
  final String amount;
  final Map address;
}
