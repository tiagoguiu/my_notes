///LOGIN EXCEPTIONS
class UserNotFoundAuthException implements Exception {}
class WrongPasswordAuthException implements Exception {}

///REGISTER EXCEPTIONS
class WeekPasswordAuthException implements Exception {}
class EmailAlreadyInUseAuthException implements Exception {}
class InvalidEmailAuthException implements Exception {}

///GENERIC EXCEPTIONS
class GenericAuthException implements Exception {}
class UserNotLoggedInAuthException implements Exception {}