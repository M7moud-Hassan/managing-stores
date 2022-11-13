import 'package:equatable/equatable.dart';

class BillHolder extends Equatable {
  String name;
  String phone;
  String address;

  BillHolder({required this.name, required this.phone, required this.address});
  @override
  List<Object?> get props => [name, phone, address];
}
