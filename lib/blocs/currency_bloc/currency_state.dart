part of 'currency_bloc.dart';

sealed class CurrencyState
    extends
        Equatable {
  final String code;
  final String symbol;
  final String name;

  const CurrencyState({
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

final class CurrencyInitial
    extends
        CurrencyState {
  const CurrencyInitial({
    required super.code,
    required super.symbol,
    required super.name,
  });
}
