import 'package:buybuddy/models/get_cart_model.dart';

class OrderModel {
  final List<CartItems> products;
  final double lat;
  final double lng;
  final int totalPrice;
  final DateTime time;

  OrderModel(this.products, this.lat ,this.lng, this.totalPrice, this.time);

  Map<String, dynamic> toJson() {
    return {
      'products': products,
      'latitude': lat,
      'longitude': lng,
      'totalPrice': totalPrice,
      'time': time.toIso8601String(),
    };
  }
}
