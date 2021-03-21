import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jourv2/models/work.dart';
import 'package:jourv2/views/new_works/edit_notes_view.dart';

class DetailScheduleView extends StatefulWidget {
  final details work;
  DetailScheduleView({Key key, @required this.work}) : super(key: key);

  @override
  _DetailScheduleViewState createState() => _DetailScheduleViewState();
}

class _DetailScheduleViewState extends State<DetailScheduleView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text('Trip Details'),
              backgroundColor: Colors.blue,
              expandedHeight: 350.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset("images/listimage.png"),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.work.name,
                    style: TextStyle(fontSize: 30, color: Colors.blue[900]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Description: ${widget.work.description}",
                    style: TextStyle(color: Colors.orange),
                  ),
                ),
                notesCard(context),
              ]),
            )
          ],
        ),
      ),
    );
  }

  Widget notesCard(context) {
    return Hero(
      tag: "TripNotes-${widget.work.name}",
      transitionOnUserGestures: true,
      child: Card(
        color: Colors.deepPurpleAccent,
        child: InkWell(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                child: Row(
                  children: <Widget>[
                    Text("Quick Notes",
                        style: TextStyle(fontSize: 24, color: Colors.white)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: setNoteText(),
                ),
              )
            ],
          ),
          onTap: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => EditNotesView(work: widget.work)));
            Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditNotesView(work: widget.work)))
                .then((value) {
              setState(() {});
            });
          },
        ),
      ),
    );
  }

  List<Widget> setNoteText() {
    if (widget.work.notes == null) {
      return [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Icon(Icons.add_circle_outline, color: Colors.grey[300]),
        ),
        Text("Click To Add Notes", style: TextStyle(color: Colors.grey[300])),
      ];
    } else {
      return [
        Text(widget.work.notes, style: TextStyle(color: Colors.grey[300]))
      ];
    }
  }
}
