import 'package:dartz/dartz.dart';
import 'package:mustafa/features/data_market/domain/entities/item.dart';
import 'package:mustafa/features/data_market/domain/repositories/item_repo.dart';
import '../../../../core/error/failures.dart';

class InsertItem {
  final ItemRepo itemRepo;
  InsertItem({required this.itemRepo});
  Future<Either<Failure, Unit>> call(Item item) => itemRepo.insert(item);
}
