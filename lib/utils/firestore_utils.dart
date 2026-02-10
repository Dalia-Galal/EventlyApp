import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/event_data_model.dart';
import 'package:firebase_core/firebase_core.dart';

abstract class FirestoreUtils {
  static CollectionReference<EventDataModel> getCollectionReference() {
    return FirebaseFirestore.instance
        .collection(EventDataModel.collectionName)
        .withConverter<EventDataModel>(
          fromFirestore: (snapshot, _) =>
              EventDataModel.fromFireStore(snapshot.data()!),
          toFirestore: (value, _) => value.toFireStore(),
        );
  }

  static Future<void> addEvent(EventDataModel data) async {
    var collectionRef = getCollectionReference();
    var documentRef = collectionRef.doc();
    data.eventId = documentRef.id;
    documentRef.set(data);
  }

  static Future<List<EventDataModel>> getDataFromFirestore(
    String categoryId,
  ) async {
    List<EventDataModel> eventsData = [];
    var collectionRef = getCollectionReference().where(
      'eventCategoryId',
      isEqualTo: categoryId,
    );
    var data = await collectionRef.get();
    data.docs.map((e) {
      eventsData.add(e.data());
    }).toList();
    return eventsData;
  }

  static Stream<QuerySnapshot<EventDataModel>> getStreamDataFromFirestore(
    String categoryId,
  ) {
    var collectionRef = getCollectionReference().where(
      'eventCategoryId',
      isEqualTo: categoryId,
    );

    return collectionRef.snapshots();
  }

  static Future<void> updateEvent(EventDataModel data) async {
    var collectionRef = getCollectionReference();
    var documentRef = collectionRef.doc(data.eventId);

    await documentRef.update(data.toFireStore());
  }

  static Future<void> deleteEvent(EventDataModel data) async {
    var collectionRef = getCollectionReference();
    var documentRef = collectionRef.doc(data.eventId);

    await documentRef.delete();
  }
}
