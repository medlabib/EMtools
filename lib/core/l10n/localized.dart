import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../presentation/providers/language_provider.dart';

/// Bilingual (French / English) clinical string value object.
///
/// Clinical free-text (indications, notes, side effects, messages, …) is
/// authored in both languages and co-located in the data layer as `LString`.
/// Enum-valued clinical results (status/severity) stay language-neutral and
/// are localized in the UI; only free-text becomes an `LString`.
///
/// Named `LString` (not `Loc`) because `Loc` is already an extension on
/// `BuildContext` in `app_strings.dart`.
@immutable
class LString {
  final String fr;
  final String en;

  static const empty = LString('', '');

  const LString(this.fr, this.en);

  /// Resolve to a concrete string for [lang].
  String resolve(AppLanguage lang) => lang == AppLanguage.english ? en : fr;

  /// French is the authoring default, so `toString()` returns it. This keeps
  /// debugging output readable but UI code should always use [resolve] /
  /// `context.tr` so the active language is honored.
  @override
  String toString() => fr;

  @override
  bool operator ==(Object other) =>
      other is LString && other.fr == fr && other.en == en;

  @override
  int get hashCode => Object.hash(fr, en);
}

/// Ambient language used by the [BuildContext.tr] resolvers.
///
/// Kept in sync by [ambientLanguageProvider], which must be watched once near
/// the app root (see `main.dart`). The existing `context.t` mechanism relies on
/// a similar statically-swapped map; this mirrors that pattern for `LString`.
AppLanguage lStringAmbientLanguage = AppLanguage.french;

/// Provider that mirrors [languageProvider] into [lStringAmbientLanguage].
///
/// Watch this once near the app root so that `context.tr` / `context.trList`
/// resolve against the currently selected language. It transitively watches
/// [languageProvider], so watching it also drives the usual language rebuild.
final ambientLanguageProvider = Provider<AppLanguage>((ref) {
  final lang = ref.watch(languageProvider);
  lStringAmbientLanguage = lang;
  return lang;
});

/// Convenience resolvers for bilingual clinical strings from a [BuildContext].
///
/// Mirrors the existing `context.t(key)` ergonomics for the `LString` model.
extension LocalizedResolvers on BuildContext {
  /// Resolve a single [LString] to the active language.
  String tr(LString value) => value.resolve(lStringAmbientLanguage);

  /// Resolve a list of [LString] to the active language.
  List<String> trList(Iterable<LString> values) =>
      values.map((v) => v.resolve(lStringAmbientLanguage)).toList();
}
