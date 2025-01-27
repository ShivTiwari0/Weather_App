class AppException implements Exception {
  final message;
  final prefix;
  AppException([this.message, this.prefix]);
  String toString() {
    return '$prefix$message';
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, 'Error During Communication');
}

class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message, 'Invalid Request');
}

class UnaurthorisedException extends AppException {
  UnaurthorisedException([String? message])
      : super(message, 'Unaurthorise Request');
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, 'Invalid Input');
}

class TooManyTaps extends AppException {
  TooManyTaps([String? message]) : super(message, ' Too Many taps');
}
