import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Container();
  }


  Future testData() async {
    await Firebase.initializeApp();
    FirebaseFirestore fs = FirebaseFirestore.instance;
    String data = '';
    await fs.collection('event_details').get().then((value) {
      value.docs.forEach((doc) {
        data += 'DocumentId: ${doc.id.toString()}\r\n';
        doc.data().forEach((key, value) {
          data += '$key: ${value.toString()}\r\n';
        });
      });
    });
    setState(() {
      _data = data ?? 'EMPTY';
    });
  }
}

