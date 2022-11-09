import 'package:mustafa/core/error/exceptions.dart';
import 'package:mustafa/features/data_market/data/datasources/remote_data.dart';
import 'package:mustafa/features/data_market/data/models/item_model.dart';
import 'package:mustafa/features/data_market/domain/entities/item.dart';
import 'package:mustafa/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:mustafa/features/data_market/domain/repositories/item_repo.dart';

class ItemRepoImp extends ItemRepo {
  final ItemRemoteData itemRemoteData;

  ItemRepoImp({required this.itemRemoteData});

  @override
  Future<Either<Failure, Unit>> insert(Item item) async {
    try {
      return right(await itemRemoteData.insert(ItemModel(
          cost: item.cost,
          count: item.count,
          id: "",
          catalogue: item.catalogue,
          name: item.name)));
    } on ItemExistsException {
      return left(ItemExistsFailure());
    } on OfflineException {
      return left(OfflineFailure());
    } on ServerException {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateItem(Item item) async {
    try {
      return right(await itemRemoteData.update(item as ItemModel));
    } on OfflineException {
      return left(OfflineFailure());
    } on ServerException {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteItem(Item item) async {
    try {
      return right(await itemRemoteData.delete(item as ItemModel));
    } on OfflineException {
      return left(OfflineFailure());
    } on ServerException {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Item>>> getAllItems(String catalogue) async {
    try {
      return right(await itemRemoteData.getAllItems(catalogue));
    } on OfflineException {
      return left(OfflineFailure());
    } on ServerException {
      return left(ServerFailure());
    }
  }
}
