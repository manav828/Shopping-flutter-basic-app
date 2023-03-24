class ProductModel {
  String? itemName;
  String? itemImage;
  int? itemPrice;
  int? itemId;
  int? itemQuantity;
  List<dynamic>? productUnit;
  ProductModel(
      {this.itemQuantity,
      this.itemId,
      this.productUnit,
      this.itemImage,
      this.itemName,
      this.itemPrice});
}
