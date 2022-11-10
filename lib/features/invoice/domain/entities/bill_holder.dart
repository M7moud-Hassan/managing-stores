import 'package:equatable/equatable.dart';

class BillHolder extends Equatable {
  String name;
  String phone;

  BillHolder({required this.name, required this.phone});
  @override
  List<Object?> get props => [name, phone];
}
