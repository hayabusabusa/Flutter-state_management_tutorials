import 'dart:async';
import 'package:flutter/material.dart';

// MARK: Localization
// 多言語対応のため？よくわからないので詳しくは公式DC
// https://flutter.dev/docs/development/accessibility-and-localization/internationalization

class FlutterBlocLocalizations {
  static FlutterBlocLocalizations of(BuildContext context) {
    return Localizations.of<FlutterBlocLocalizations>(
      context, 
      FlutterBlocLocalizations,
    );
  }

  String get appTitle => "Flutter Todos";
}

class FlutterBlocLocalizationsDelegate 
  extends LocalizationsDelegate<FlutterBlocLocalizations> {

  @override
  Future<FlutterBlocLocalizations> load(Locale locale) => Future(() => FlutterBlocLocalizations());

  @override
  bool shouldReload(LocalizationsDelegate<FlutterBlocLocalizations> old) => false;

  @override
  bool isSupported(Locale locale) => locale.languageCode.toLowerCase().contains("en");
}