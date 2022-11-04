import 'package:equatable/equatable.dart';

class Catalogue extends Equatable {
  final String name;
  final String id;
  const Catalogue({required this.name, required this.id});
  @override
  List<Object?> get props => [name, id];
}
