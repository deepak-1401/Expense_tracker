part of 'theme_bloc.dart';

sealed class ThemeEvent
    extends
        Equatable {
  const ThemeEvent();

  @override
  List<
    Object
  >
  get props => [];
}

final class LoadSavedTheme
    extends
        ThemeEvent {}

final class LightThemeSelected
    extends
        ThemeEvent {}

final class DarkThemeSelected
    extends
        ThemeEvent {}
