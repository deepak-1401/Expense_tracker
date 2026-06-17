part of 'currency_bloc.dart';

sealed class CurrencyEvent
    extends
        Equatable {
  const CurrencyEvent();

  @override
  List<
    Object
  >
  get props => [];
}

class CurrencyChanged
    extends
        CurrencyEvent {
  final String code;
  final String symbol;
  final String name;

  const CurrencyChanged({
    required this.code,
    required this.symbol,
    required this.name,
  });

  @override
  List<
    Object
  >
  get props => [
    code,
    symbol,
    name,
  ];
}
