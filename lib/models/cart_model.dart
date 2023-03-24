class CartModel {
  String? itemName;
  String? itemImage;
  int? itemPrice;
  int? itemId;
  int? itemQuantity;
  List<dynamic>? productUnit;
  CartModel(
      {this.itemQuantity,
      this.itemId,
      this.productUnit,
      this.itemImage,
      this.itemName,
      this.itemPrice});
}
