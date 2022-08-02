import 'package:cloud_firestore/cloud_firestore.dart';

import 'constants.dart';


class CloudNote {
  final String documendId;
  final String ownerUserId;
  final String text;

  CloudNote({
    required this.documendId,
    required this.ownerUserId,
    required this.text,
  });

  CloudNote.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documendId = snapshot.id,
        ownerUserId = snapshot.data()[ownerUserIdFieldName],
        text = snapshot.data()[textFieldName] as String;
}
