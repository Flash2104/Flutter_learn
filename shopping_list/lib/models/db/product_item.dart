class DbProductItem {
  int id;
  int productLists;
  String name;
  String quantity;
  String note;

  DbProductItem(this.id, this.productLists, this.name, this.quantity, this.note);

  Map<String, dynamic> toMap() {
    return {'id': id == 0 ? null : id, 'productLists': productLists, 'name': name, 'quantity': quantity, 'note': note};
  }
}
