import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_events/models/event_details.dart';
import 'package:flutter_events/models/favorite.dart';

class FirestoreHelper {
  static final FirebaseFirestore db = FirebaseFirestore.instance;
  static const FAVORITES = 'favorites';

  static Future addFavorite(EventDetailsModel eventDetailsModel, String userId) {
    FavoriteEventModel fav = FavoriteEventModel(null, eventDetailsModel.id, userId);
    var res = db
        .collection(FAVORITES)
        .add(fav.toMap())
        .then((value) => print('Добавлено событие в избранное: $value'))
        .catchError((err) => print('При добавлении в избранное произошла ошибка:\r\n $err'));
    return res;
  }

  static Future deleteFavorite(String favId) async {
    await db.collection(FAVORITES).doc(favId).delete();
  }

  static Future<List<FavoriteEventModel>> getFavorites(String uid) async {
    var res = await db.collection(FAVORITES).where('userId', isEqualTo: uid).get();
    return res.docs?.map((e) => FavoriteEventModel.fromDoc(e))?.toList() ?? List<FavoriteEventModel>();
  }
}
