import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class details {
  String tag;
  String name;
  String description;
  int importance;
  DateTime startDate;
  DateTime endDate;
  String photoReference;
  String notes;
  String documentId;

  details(
    this.tag,
    this.name,
    this.description,
    this.importance,
    this.startDate,
    this.endDate,
  );

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'tag': tag,
        'importance': importance,
        'startDate': startDate,
        'endDate': endDate,
        'photoReference': photoReference,
      };

  details.fromSnapshot(DocumentSnapshot snapshot)
      : name = snapshot.data()['name'],
        startDate = snapshot.data()['startDate'].toDate(),
        endDate = snapshot.data()['endDate'].toDate(),
        description = snapshot.data()['description'],
        tag = snapshot.data()['tag'],
        importance = snapshot.data()['importance'],
        photoReference = snapshot.data()['photoReference'],
        notes = snapshot.data()['notes'],
        documentId = snapshot.id;
}
