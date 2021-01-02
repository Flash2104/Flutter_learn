import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MainWidget());
}

class MainWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.orange),
      title: 'Events',
      home: Scaffold(
        appBar: AppBar(title: Text('События')),
        body: MainBodyView(),
      )
    );
  }
}

class MainBodyView extends StatefulWidget {
  @override
  _MainBodyViewState createState() => _MainBodyViewState();
}

class _MainBodyViewState extends State<MainBodyView> {
  String _data;

  @override
  void initState() {
    testData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: Text('События тут: \r\n $_data)',));
  }

  Future testData() async {
    await Firebase.initializeApp();
    FirebaseFirestore fs = FirebaseFirestore.instance;
    String data = '';
    await fs.collection('event_details').get().then((value) {
      value.
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


