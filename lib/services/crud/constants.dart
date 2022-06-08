const String dbName = 'notes.db';
const String noteTable = 'note';
const String userTable = 'user';

const createNoteTable = '''
          CREATE TABLE IF NOT EXISTS "note" (
            "id"	INTEGER NOT NULL,
            "user_id"	INTEGER NOT NULL,
            "text"	TEXT,
            FOREIGN KEY("user_id") REFERENCES "user"("id"),
            PRIMARY KEY("id" AUTOINCREMENT)
          );
                              ''';

const createUserTable = '''
        CREATE TABLE IF NOT EXISTS "user" (
          "id"	INTEGER NOT NULL,
          "email"	TEXT NOT NULL UNIQUE,
          PRIMARY KEY("id" AUTOINCREMENT)
        );
                              ''';
