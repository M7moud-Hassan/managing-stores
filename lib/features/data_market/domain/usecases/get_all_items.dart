import 'package:dartz/dartz.dart';
import 'package:mustafa/features/data_market/domain/repositories/item_repo.dart';

import '../../../../core/error/failures.dart';
import '../entities/item.dart';

class GetAllItems {
  final ItemRepo itemRepo;
  GetAllItems({required this.itemRepo});

  Future<Either<Failure, List<Item>>> call(String catalogue) =>
      itemRepo.getAllItems(catalogue);
}
