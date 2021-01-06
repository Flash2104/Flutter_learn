import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_events/models/event_details.dart';
import 'package:flutter_events/models/favorite.dart';
import 'package:flutter_events/screens/login_screen.dart';
import 'package:flutter_events/shared/auth.dart';
import 'package:flutter_events/shared/firestore_helper.dart';

class EventScreen extends StatelessWidget {
  final String _uid;

  EventScreen(this._uid);

  @override
  Widget build(BuildContext context) {
    var auth = Authentication();
    return Scaffold(
      appBar: AppBar(
        title: Text('События'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              auth.signOut().then((value) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
              });
            },
          )
        ],
      ),
      body: EventList(_uid),
    );
  }
}

class EventList extends StatefulWidget {
  final String uid;

  EventList(this.uid);

  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  List<EventDetailsModel> _events = List<EventDetailsModel>();
  List<FavoriteEventModel> _favorites = List<FavoriteEventModel>();

  @override
  void initState() {
    if (mounted) {
      this._fillEvents();
      FirestoreHelper.getFavorites(widget.uid).then((value) {
        setState(() {
          _favorites = value;
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _events != null ? _events.length : 0,
      itemBuilder: (context, index) {
        var event = _events[index];
        if (event.description == null) {
          return ListTile();
        }
        var starColor = _isUserFavorite(event.id) ? Colors.amber : Colors.grey;
        return ListTile(
          title: Text(event.description),
          subtitle: Text('Дата: ${event.date} - Начало: ${event.startTime} - Конец: ${event.endTime}'),
          trailing: IconButton(
            icon: Icon(Icons.star, color: starColor),
            onPressed: () => toggleFavorite(event),
          ),
        );
      },
    );
  }

  bool _isUserFavorite(String eventId) {
    var fav = _favorites.firstWhere((element) => element.eventId == eventId, orElse: () => null);
    return fav != null;
  }

  Future _fillEvents() async {
    FirebaseFirestore fs = FirebaseFirestore.instance;
    List<EventDetailsModel> events = List<EventDetailsModel>();
    await fs.collection('event_details').get().then((value) {
      value.docs?.forEach((doc) {
        var event = EventDetailsModel.fromMap(doc.data());
        if (event.id == null) {
          event.id = doc.id;
        }
        events.add(event);
      });
    });
    setState(() {
      _events = events ?? 'EMPTY';
    });
  }

  Future toggleFavorite(EventDetailsModel event) async {
    if(_isUserFavorite(event.id)) {
      List<String> favIds = _favorites.where((element) => element.eventId == event.id).map((e) => e.id).toList();
      favIds.forEach((element) {
        FirestoreHelper.deleteFavorite(element);
      });
    } else {
      FirestoreHelper.addFavorite(event, widget.uid);
    }
    var updated = await FirestoreHelper.getFavorites(widget.uid);
    setState(() {
      _favorites = updated;
    });
  }
}
