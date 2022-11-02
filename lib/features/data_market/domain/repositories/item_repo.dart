import 'package:dartz/dartz.dart';
import 'package:mustafa/core/error/failures.dart';
import 'package:mustafa/features/data_market/domain/entities/item.dart';

abstract class ItemRepo {
  Future<Either<Failure, Unit>> insert(Item item);
  Future<Either<Failure, Unit>> deleteItem(Item item);
  Future<Either<Failure, Unit>> updateItem(Item item);
  Future<Either<Failure, List<Item>>> getAllItems(String catalogue);
}
