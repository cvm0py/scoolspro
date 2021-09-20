// Dart imports:
import 'dart:ui';

class Application {
  static final Application _application = Application._internal();

  factory Application() {
    return _application;
  }

  Application._internal();

  final List<String> supportedLanguages = [
    "English",
    "Simplified Chinese",
    "Traditional chinese"
  ];

  final List<String> supportedLanguagesCodes = ["en", "zh-Hans", "zh-Hant"];

  //returns the list of supported Locales
  Iterable<Locale> supportedLocales() =>
      supportedLanguagesCodes.map<Locale>((language) => Locale(language, ""));

  //function to be invoked when changing the language
  LocaleChangeCallback onLocaleChanged;
}

Application application = Application();

typedef void LocaleChangeCallback(Locale locale);

final List<String> languagesList = application.supportedLanguages;
final List<String> languageCodesList = application.supportedLanguagesCodes;

final Map<dynamic, dynamic> languagesMap = {
  languagesList[0]: languageCodesList[0],
  languagesList[1]: languageCodesList[1],
  languagesList[2]: languageCodesList[2]
};
