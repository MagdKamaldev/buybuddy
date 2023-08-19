import 'package:buybuddy/models/favourites_model.dart';
import 'package:geolocator/geolocator.dart';

class OrderModel {
  final List<Product>  products;
  final Position loaction;
  final  double totalPrice;

  OrderModel(this.products, this.loaction, this.totalPrice);
}
