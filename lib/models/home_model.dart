class HomeModel {
  bool? status;
  HomeDataModel? data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    data = HomeDataModel.fromJson(json["data"]);
  }
}

class HomeDataModel {
  List<ProductModel> products = [];
  List<BannerModel> banners = [];
  HomeDataModel.fromJson(Map<String, dynamic> json) {
    json["banners"].forEach((element) {
      banners.add(BannerModel.fromJson(element));
    });
    json["products"].forEach((element) {
      products.add(ProductModel.fromJson(element));
    });
  }
}

class ProductModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  String? image;
  String? name;
  dynamic discount;
  bool? inFavourites;
  bool? inCart;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    discount = json["discount"];
    price = json["price"];
    oldPrice = json["old_price"];
    image = json["image"];
    name = json["name"];
    inFavourites = json["in_favourites"];
    inCart = json["in_cart"];
  }
}

class BannerModel {
  int? id;
  String? image;
  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    image = json["image"];
  }
}
