import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class OfflineFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class EmptyCacheFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class CatalogueExitsFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class ItemExistsFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class CountItemNotenoughFailure extends Failure {
  @override
  List<Object?> get props => [];
}
