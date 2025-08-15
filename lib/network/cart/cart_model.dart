class CartModel {
  int? id;
  int? userId;
  String? date;
  List<CartProduct>? products;

  CartModel({this.id, this.userId, this.date, this.products});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    date = json['date'];
    if (json['products'] != null) {
      products = <CartProduct>[];
      json['products'].forEach((v) {
        products!.add(CartProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['date'] = date;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartProduct {
  int? productId;
  int? quantity;

  CartProduct({this.productId, this.quantity});

  CartProduct.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['quantity'] = quantity;
    return data;
  }
}
