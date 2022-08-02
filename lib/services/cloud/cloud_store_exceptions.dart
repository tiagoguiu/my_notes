class CloudStoreException implements Exception {
  const CloudStoreException();
}

//C in crud
class CouldNotCreateNoteException extends CloudStoreException {}
//R in crud
class CouldNotGetAllNotesException extends CloudStoreException {}
//U in crud
class CouldNotUpdateNoteException extends CloudStoreException {}
//D in crud
class CouldNotDeleteNoteException extends CloudStoreException {}