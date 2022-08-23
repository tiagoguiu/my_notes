import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vandad_flutter_course/services/cloud/cloud.dart';

class FirebaseCloudStorage {
  //singleton
  static final FirebaseCloudStorage _shared = FirebaseCloudStorage._sharedInstance();
  FirebaseCloudStorage._sharedInstance();
  factory FirebaseCloudStorage() => _shared;

  final notes = FirebaseFirestore.instance.collection('notes');

  Stream<Iterable<CloudNote>> allNotes({required String ownerUserId}) => notes.snapshots().map(
        (event) => event.docs
            .map(
              (doc) => CloudNote.fromSnapshot(doc),
            )
            .where((note) => note.ownerUserId == ownerUserId),
      );

  void createNewNote({required String ownerUserId}) async {
    await notes.add({
      ownerUserIdFieldName: ownerUserId,
      textFieldName: '',
    });
  }

  Future<Iterable<CloudNote>> getNotes({required String ownerUserId}) async {
    try {
      return await notes.where(ownerUserId).get().then(
            (value) => value.docs.map(
              (doc) {
                return CloudNote(
                  documendId: doc.id,
                  ownerUserId: doc.data()[ownerUserId] as String,
                  text: doc.data()[textFieldName] as String,
                );
              },
            ),
          );
    } catch (e) {
      throw CouldNotGetAllNotesException();
    }
  }

  Future<void> updateNote({
    required String documentId,
    required String text,
  }) async {
    try {
      await notes.doc(documentId).update({textFieldName: text});
    } catch (e) {
      throw CouldNotUpdateNoteException();
    }
  }

  Future<void> deleteNote({required String documentId}) async {
    try {
      await notes.doc(documentId).delete();
    } catch (e) {
      throw CouldNotDeleteNoteException();
    }
  }
}
