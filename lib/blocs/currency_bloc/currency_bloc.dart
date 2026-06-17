import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'currency_event.dart';
part 'currency_state.dart';

class CurrencyBloc
    extends
        Bloc<
          CurrencyEvent,
          CurrencyState
        > {
  CurrencyBloc()
    : super(
        const CurrencyInitial(
          code: 'INR',
          symbol: '₹',
          name: 'Indian Rupee',
        ),
      ) {
    on<
      CurrencyChanged
    >(
      (
        event,
        emit,
      ) {
        emit(
          CurrencyInitial(
            code: event.code,
            symbol: event.symbol,
            name: event.name,
          ),
        );
      },
    );
  }
}
