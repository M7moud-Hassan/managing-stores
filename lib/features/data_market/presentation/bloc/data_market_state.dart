part of 'data_market_bloc.dart';

abstract class DataMarketState extends Equatable {
  const DataMarketState();  

  @override
  List<Object> get props => [];
}
class DataMarketInitial extends DataMarketState {}
