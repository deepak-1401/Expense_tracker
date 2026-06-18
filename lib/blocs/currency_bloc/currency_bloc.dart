import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
      LoadSavedCurrency
    >(
      (
        event,
        emit,
      ) async {
        final prefs = await SharedPreferences.getInstance();

        emit(
          CurrencyInitial(
            code:
                prefs.getString(
                  'currency_code',
                ) ??
                'INR',
            symbol:
                prefs.getString(
                  'currency_symbol',
                ) ??
                '₹',
            name:
                prefs.getString(
                  'currency_name',
                ) ??
                'Indian Rupee',
          ),
        );
      },
    );

    on<
      CurrencyChanged
    >(
      (
        event,
        emit,
      ) async {
        final prefs = await SharedPreferences.getInstance();

        await prefs.setString(
          'currency_code',
          event.code,
        );

        await prefs.setString(
          'currency_symbol',
          event.symbol,
        );

        await prefs.setString(
          'currency_name',
          event.name,
        );

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
