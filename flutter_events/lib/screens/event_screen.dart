import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_events/models/event_details.dart';

class EventScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('События')),
      body: EventList(),
    );
  }
}

class EventList extends StatefulWidget {
  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  List<EventDetailsModel> _events = List<EventDetailsModel>();

  @override
  void initState() {
    if(mounted) {
      this._fillEvents();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _events != null ? _events.length : 0,
        itemBuilder: (context, index) {
          var event = _events[index];
          if(event.description == null) {
            return ListTile();
          }
          return ListTile(
            title: Text(event.description),
            subtitle: Text('Дата: ${event.date} - Начало: ${event.startTime} - Конец: ${event.endTime}'),
          );
        },
    );
  }

  Future _fillEvents() async {
    await Firebase.initializeApp();
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
}
