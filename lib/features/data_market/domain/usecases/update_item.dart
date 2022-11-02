import 'package:dartz/dartz.dart';
import 'package:mustafa/features/data_market/domain/repositories/item_repo.dart';

import '../../../../core/error/failures.dart';
import '../entities/item.dart';

class UpdateItem {
  final ItemRepo itemRepo;
  UpdateItem({required this.itemRepo});
  Future<Either<Failure, Unit>> call(Item item) => itemRepo.updateItem(item);
}
