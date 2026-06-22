// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Good morning,`
  String get goodMorning {
    return Intl.message(
      'Good morning,',
      name: 'goodMorning',
      desc: '',
      args: [],
    );
  }

  /// `Search clothes...`
  String get searchClothes {
    return Intl.message(
      'Search clothes...',
      name: 'searchClothes',
      desc: '',
      args: [],
    );
  }

  /// `All Items`
  String get allItem {
    return Intl.message('All Items', name: 'allItem', desc: '', args: []);
  }

  /// `Dress`
  String get dress {
    return Intl.message('Dress', name: 'dress', desc: '', args: []);
  }

  /// `T-Shirt`
  String get tShirt {
    return Intl.message('T-Shirt', name: 'tShirt', desc: '', args: []);
  }

  /// `Pants`
  String get pants {
    return Intl.message('Pants', name: 'pants', desc: '', args: []);
  }

  /// `Modern Light Clothes`
  String get modernLightClothes {
    return Intl.message(
      'Modern Light Clothes',
      name: 'modernLightClothes',
      desc: '',
      args: [],
    );
  }

  /// `Light Dress Bless`
  String get lightDressBless {
    return Intl.message(
      'Light Dress Bless',
      name: 'lightDressBless',
      desc: '',
      args: [],
    );
  }

  /// `Jacket Dark`
  String get jacketDark {
    return Intl.message('Jacket Dark', name: 'jacketDark', desc: '', args: []);
  }

  /// `Casual Shirt`
  String get casualShirt {
    return Intl.message(
      'Casual Shirt',
      name: 'casualShirt',
      desc: '',
      args: [],
    );
  }

  /// `Dress modern`
  String get dressModern {
    return Intl.message(
      'Dress modern',
      name: 'dressModern',
      desc: '',
      args: [],
    );
  }

  /// `Jacket`
  String get jacket {
    return Intl.message('Jacket', name: 'jacket', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
