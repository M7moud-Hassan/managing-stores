import 'package:equatable/equatable.dart';

class BillHolder extends Equatable {
  String name;
  String phone;
  String address;
  String? fileName;
  String? dateDay;

  BillHolder(
      {required this.name,
      required this.phone,
      required this.address,
      this.fileName,
      this.dateDay});
  @override
  List<Object?> get props => [name, phone, address, fileName, dateDay];

  factory BillHolder.fromJson(Map<String, dynamic> json) => BillHolder(
      name: json["name"],
      phone: json["phone"],
      address: json["address"],
      fileName: json["fileName"],
      dateDay: json["dateDay"]);

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "address": address,
        "fileName": fileName,
        "dateDay": dateDay
      };
}
