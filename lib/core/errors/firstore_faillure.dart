

import 'package:pet_care/core/errors/common_faillure.dart';

class PermissionDeniedFailure extends ErrorFailure {
  const PermissionDeniedFailure()
      : super('You do not have permission to perform this operation.');
}

class DocumentNotFoundFailure extends ErrorFailure {
  const DocumentNotFoundFailure()
      : super('The requested document was not found.');
}