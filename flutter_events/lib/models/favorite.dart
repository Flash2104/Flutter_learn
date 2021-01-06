import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteEventModel {
  String _id;
  String _eventId;
  String _userId;

  String get eventId => _eventId;

  String get id => _id;

  FavoriteEventModel(this._id, this._eventId, this._userId);

  FavoriteEventModel.fromDoc(DocumentSnapshot doc) {
    _id = doc.id;
    _eventId = doc.get('eventId');
    _userId = doc.get('userId');
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['eventId'] = _eventId;
    map['userId'] = _userId;
    return map;
  }
}
