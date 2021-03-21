import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jourv2/models/work.dart';
import 'package:jourv2/widget/provider_widget.dart';
import 'package:jourv2/services/loading.dart';
import 'detail_schedule_view.dart';

Icon buildChild(tag) {
  if (tag == 'official') {
    return Icon(Icons.work);
  } else if (tag == 'health') {
    return Icon(Icons.local_hospital);
  } else if (tag == 'unofficial') {
    return Icon(Icons.insert_drive_file);
  } else if (tag == 'family') {
    return Icon(Icons.people);
  }
}

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
          stream: getUsersWorksStreamSnapshot(context),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Loading();
            return new ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index) =>
                    buildWorkCard(context, snapshot.data.documents[index]));
          }),
    );
  }

  Stream<QuerySnapshot> getUsersWorksStreamSnapshot(
      BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* FirebaseFirestore.instance
        .collection("userData")
        .doc(uid)
        .collection("works")
        .snapshots();
  }

  Widget buildWorkCard(BuildContext context, DocumentSnapshot document) {
    final work = details.fromSnapshot(document);

    return new Container(
      child: Card(
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        work.name,
                        style: new TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.w500),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: <Widget>[
                      Text(document['description']),
                      Spacer(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                          "${DateFormat('dd/MM/yyyy').format(document['startDate'].toDate()).toString()} - ${DateFormat('dd/MM/yyyy').format(document['endDate'].toDate()).toString()}"),
                      Spacer(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    children: <Widget>[
                      Text(document['tag'], style: new TextStyle(fontSize: 20)),
                      buildChild(document['tag']),
                      Spacer(),
                      CircleAvatar(
                        radius: 25.0,
                        backgroundColor:
                            Colors.blueGrey[document['importance']],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailScheduleView(
                        work: work,
                      )),
            );
          },
        ),
      ),
    );
  }
}
