import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/l10n/app_strings.dart';

enum AppLanguage { french, english }

final languageChangeNotifier = ValueNotifier<int>(0);

final languageProvider = NotifierProvider<LanguageNotifier, AppLanguage>(
  LanguageNotifier.new,
);

class LanguageNotifier extends Notifier<AppLanguage> {
  static const _langKey = 'app_language';

  @override
  AppLanguage build() {
    AppStrings.setLanguage(AppLanguage.french.index);
    _loadLanguage();
    return AppLanguage.french;
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final lang = prefs.getString(_langKey);
    final newLang = lang == 'english' ? AppLanguage.english : AppLanguage.french;
    state = newLang;
    AppStrings.setLanguage(newLang.index);
    languageChangeNotifier.value++;
  }

  Future<void> setLanguage(AppLanguage lang) async {
    debugPrint('[LanguageNotifier] setLanguage → $lang (index=${lang.index})');
    state = lang;
    AppStrings.setLanguage(lang.index);
    languageChangeNotifier.value++;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_langKey, lang == AppLanguage.english ? 'english' : 'french');
  }

  Future<void> toggleLanguage() async {
    await setLanguage(
      state == AppLanguage.english ? AppLanguage.french : AppLanguage.english,
    );
  }
}
