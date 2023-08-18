// ignore_for_file: null_check_always_fails
class CartData {
  final bool status;
  final dynamic message;
  final Data data;

  CartData({
    required this.status,
    required this.message,
    required this.data,
  });


  factory CartData.fromJson(Map<String, dynamic> json) {
    return CartData(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null!,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = this.data.toJson();
    return data;
  }
}

class Data {
  final List<dynamic> cartItems;
  final int subTotal;
  final int total;

  Data({
    required this.cartItems,
    required this.subTotal,
    required this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      cartItems: List<dynamic>.from(json['cart_items']),
      subTotal: json['sub_total'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cart_items'] = cartItems;
    data['sub_total'] = subTotal;
    data['total'] = total;
    return data;
  }
}
