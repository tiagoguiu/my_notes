class DataBaseUser {
  final int id;
  final String email;

  DataBaseUser({
    required this.id,
    required this.email,
  });

  DataBaseUser.fromRow(Map<String, Object?> map)
      : id = map['id'] as int,
        email = map['email'] as String;

  @override
  String toString() => 'Person, ID = $id, email = $email';

  @override
  bool operator ==(covariant DataBaseUser other) => id == other.id;
  
  @override
  int get hashCode => id.hashCode;
  
}
