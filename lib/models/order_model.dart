import 'package:buybuddy/models/get_cart_model.dart';

class OrderModel {
  List<CartItems> cartItems;
  double latitude;
  double longitude;
  num total;
  DateTime timestamp;
  String adress;
  OrderModel(this.cartItems, this.latitude, this.longitude, this.total,this.adress,
      this.timestamp);

  // Convert an OrderModel instance to a JSON Map
  Map<String, dynamic> toJson() {
    return {
      'cartItems': cartItems.map((item) => item.toJson()).toList(),
      'latitude': latitude,
      'longitude': longitude,
      'total': total,
      'timestamp': timestamp.toIso8601String(),
      "adress":adress,
    };
  }

  // Create an OrderModel instance from a JSON Map
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      (json['cartItems'] as List)
          .map((itemJson) => CartItems.fromJson(itemJson))
          .toList(),
      json['latitude'],
      json['longitude'],
      json['total'],
      json["adress"],
      DateTime.parse(json['timestamp']),
      
    );
  }
}
