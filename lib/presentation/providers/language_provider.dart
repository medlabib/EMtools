import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppLanguage { french, english }

final languageChangeNotifier = ValueNotifier<int>(0);

final languageProvider = NotifierProvider<LanguageNotifier, AppLanguage>(
  LanguageNotifier.new,
);

class LanguageNotifier extends Notifier<AppLanguage> {
  static const _langKey = 'app_language';

  @override
  AppLanguage build() {
    _loadLanguage();
    return AppLanguage.french;
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final lang = prefs.getString(_langKey);
    state = lang == 'english' ? AppLanguage.english : AppLanguage.french;
  }

  Future<void> setLanguage(AppLanguage lang) async {
    state = lang;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_langKey, lang == AppLanguage.english ? 'english' : 'french');
    languageChangeNotifier.value++;
  }

  Future<void> toggleLanguage() async {
    await setLanguage(
      state == AppLanguage.english ? AppLanguage.french : AppLanguage.english,
    );
  }
}
