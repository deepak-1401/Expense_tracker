import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc
    extends
        Bloc<
          ThemeEvent,
          ThemeState
        > {
  ThemeBloc()
    : super(
        DarkThemeState(),
      ) {
    on<
      LoadSavedTheme
    >(
      (
        event,
        emit,
      ) async {
        final prefs = await SharedPreferences.getInstance();
        final savedTheme = prefs.getString(
          'app_theme',
        );

        if (savedTheme ==
            'light') {
          emit(
            LightThemeState(),
          );
        } else {
          emit(
            DarkThemeState(),
          );
        }
      },
    );

    on<
      LightThemeSelected
    >(
      (
        event,
        emit,
      ) async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(
          'app_theme',
          'light',
        );
        emit(
          LightThemeState(),
        );
      },
    );

    on<
      DarkThemeSelected
    >(
      (
        event,
        emit,
      ) async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(
          'app_theme',
          'dark',
        );
        emit(
          DarkThemeState(),
        );
      },
    );
  }
}
