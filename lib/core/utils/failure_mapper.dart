

import '../exceptions/failure.dart';
import 'constants.dart';

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure: ServerFailure serverFailure = failure as ServerFailure;
    return serverFailure.message;
    default: return Constants.UNEXPECTED_FAILURE_MESSAGE;
  }
}