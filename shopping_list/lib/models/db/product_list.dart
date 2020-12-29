class DbProductList {
  int id;
  String name;
  int priority;

  DbProductList(this.id, this.name, this.priority);

  DbProductList.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.priority = map['priority'];
  }

  Map<String, dynamic> toMap() {
    return {'id': id == 0 ? null : id, 'name': name, 'priority': priority};
  }
}
