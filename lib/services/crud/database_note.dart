// ignore_for_file: public_member_api_docs, sort_constructors_first
class DatabaseNote {
  final int id;
  final int userId;
  final String text;

  DatabaseNote({
    required this.id,
    required this.userId,
    required this.text,
  });

  DatabaseNote.fromRow(Map<String, Object?> map)
      : id = map['id'] as int,
        userId = map['user_id'] as int,
        text = map['text'] as String;

  @override
  String toString() => 'Note = $id, userId = $userId';

  @override
  bool operator ==(covariant DatabaseNote other) => id == other.id;

  @override
  int get hashCode => id.hashCode;
}

