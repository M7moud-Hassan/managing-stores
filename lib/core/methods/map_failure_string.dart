import 'package:mustafa/core/strings/messages.dart';

import '../error/failures.dart';
import '../strings/failures.dart';

String mapError(Failure failure) {
  switch (failure.runtimeType) {
    case ItemExistsFailure:
      return ITEM_EXITS;
    case OfflineFailure:
      return OFFLINE_FAILURE_MESSAGE;
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    default:
      return SERVER_FAILURE_MESSAGE;
  }
}
