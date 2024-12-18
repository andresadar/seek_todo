import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

/// Clase abstracta que define los temas personalizados para la aplicación.
abstract class CustomTheme {
  /// Esquema de color base utilizado para los temas.
  static const FlexScheme _scheme = FlexScheme.deepPurple;

  /// Tema base para modo claro.
  static ThemeData get _baseLight => FlexThemeData.light(
      scheme: _scheme, fontFamily: 'Nunito', useMaterial3: true);

  /// Tema base para modo oscuro.
  static ThemeData get _baseDark => FlexThemeData.dark(
      scheme: _scheme, fontFamily: 'Nunito', useMaterial3: true);

  /// Tema final para modo claro, con configuraciones personalizadas.
  static ThemeData get light => _baseLight.copyWith(
        appBarTheme: _appBarTheme(theme: _baseLight),
        inputDecorationTheme: _inputTheme(theme: _baseLight),
        elevatedButtonTheme: _elevatedButtonTheme(theme: _baseLight),
        checkboxTheme: _checkboxThemeData(theme: _baseLight),
      );

  /// Tema final para modo oscuro, con configuraciones personalizadas.
  static ThemeData get dark => _baseDark.copyWith(
        appBarTheme: _appBarTheme(theme: _baseDark),
        inputDecorationTheme: _inputTheme(theme: _baseDark),
        elevatedButtonTheme: _elevatedButtonTheme(theme: _baseDark),
        checkboxTheme: _checkboxThemeData(theme: _baseDark),
      );

  /// Configuración personalizada para AppBar.
  static AppBarTheme _appBarTheme({required ThemeData theme}) => AppBarTheme(
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: theme.colorScheme.onPrimary),
        backgroundColor: theme.colorScheme.primary,
        titleTextStyle:
            TextStyle(color: theme.colorScheme.onPrimary, fontSize: 18),
      );

  /// Configuración personalizada para los campos de texto.
  static InputDecorationTheme _inputTheme({required ThemeData theme}) =>
      InputDecorationTheme(
        hintStyle: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
        isDense: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(width: .1),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(width: .1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(width: .6, color: theme.colorScheme.primary),
        ),
      );

  /// Configuración personalizada para botones elevados.
  static ElevatedButtonThemeData _elevatedButtonTheme(
          {required ThemeData theme}) =>
      ElevatedButtonThemeData(
        style: ButtonStyle(
          padding: const WidgetStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 20, vertical: 14)),
          shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(7))),
          backgroundColor:
              WidgetStatePropertyAll(theme.colorScheme.primaryContainer),
          textStyle: WidgetStatePropertyAll(
            TextStyle(
                color: theme.colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.w400),
          ),
        ),
      );

  /// Configuración personalizada para los checkboxes.
  static CheckboxThemeData _checkboxThemeData({required ThemeData theme}) =>
      CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      );
}
