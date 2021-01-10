class PlaceModel {
  int id;
  String name;
  double latitude;
  double longitude;
  String image;

  PlaceModel(this.id, this.name, this.latitude, this.longitude, this.image);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id != 0 ? id : null;
    map['name'] = name;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['image'] = image;
    return map;
  }
}
