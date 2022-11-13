import 'package:dartz/dartz.dart';
import 'package:mustafa/features/data_market/domain/entities/item.dart';

import '../../../../core/error/failures.dart';
import '../../../invoice/domain/entities/bill.dart';
import '../repositories/item_repo.dart';

class UpdateForInvoiceUserCase {
  final ItemRepo itemRepo;
  UpdateForInvoiceUserCase({required this.itemRepo});
  Future<Either<Failure, Unit>> call(Bill bill) =>
      itemRepo.updateItemForInvoice(bill);
}
