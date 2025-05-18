import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pl')
  ];

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'EVOLUTION 2048'**
  String get title;

  /// No description provided for @subtitle.
  ///
  /// In en, this message translates to:
  /// **'From bacteria to human'**
  String get subtitle;

  /// No description provided for @play.
  ///
  /// In en, this message translates to:
  /// **'PLAY'**
  String get play;

  /// No description provided for @prokaryote.
  ///
  /// In en, this message translates to:
  /// **'Prokaryote'**
  String get prokaryote;

  /// No description provided for @fish.
  ///
  /// In en, this message translates to:
  /// **'Fish'**
  String get fish;

  /// No description provided for @mammal.
  ///
  /// In en, this message translates to:
  /// **'Mammal'**
  String get mammal;

  /// No description provided for @human.
  ///
  /// In en, this message translates to:
  /// **'Human'**
  String get human;

  /// No description provided for @score.
  ///
  /// In en, this message translates to:
  /// **'Score'**
  String get score;

  /// No description provided for @bestScore.
  ///
  /// In en, this message translates to:
  /// **'Best'**
  String get bestScore;

  /// No description provided for @newGame.
  ///
  /// In en, this message translates to:
  /// **'New Game'**
  String get newGame;

  /// No description provided for @howToPlay.
  ///
  /// In en, this message translates to:
  /// **'How to play?'**
  String get howToPlay;

  /// No description provided for @helpSwipe.
  ///
  /// In en, this message translates to:
  /// **'Swipe to move the tiles.'**
  String get helpSwipe;

  /// No description provided for @helpMerge.
  ///
  /// In en, this message translates to:
  /// **'Merge identical tiles to evolve.'**
  String get helpMerge;

  /// No description provided for @helpEvolve.
  ///
  /// In en, this message translates to:
  /// **'Reach the highest evolution!'**
  String get helpEvolve;

  /// No description provided for @amoeba.
  ///
  /// In en, this message translates to:
  /// **'Amoeba'**
  String get amoeba;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @gameOver.
  ///
  /// In en, this message translates to:
  /// **'Game Over!'**
  String get gameOver;

  /// No description provided for @playAgain.
  ///
  /// In en, this message translates to:
  /// **'Play Again'**
  String get playAgain;

  /// No description provided for @youWin.
  ///
  /// In en, this message translates to:
  /// **'You Win!'**
  String get youWin;

  /// No description provided for @reachedHuman.
  ///
  /// In en, this message translates to:
  /// **'You reached Homo sapiens!'**
  String get reachedHuman;

  /// No description provided for @continueGame.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueGame;

  /// No description provided for @colony.
  ///
  /// In en, this message translates to:
  /// **'Multicellular Colony'**
  String get colony;

  /// No description provided for @jellyfish.
  ///
  /// In en, this message translates to:
  /// **'Jellyfish'**
  String get jellyfish;

  /// No description provided for @amphibian.
  ///
  /// In en, this message translates to:
  /// **'Amphibian'**
  String get amphibian;

  /// No description provided for @reptile.
  ///
  /// In en, this message translates to:
  /// **'Reptile'**
  String get reptile;

  /// No description provided for @primate.
  ///
  /// In en, this message translates to:
  /// **'Primate'**
  String get primate;

  /// No description provided for @earlyHuman.
  ///
  /// In en, this message translates to:
  /// **'Homo habilis'**
  String get earlyHuman;

  /// No description provided for @modernHuman.
  ///
  /// In en, this message translates to:
  /// **'Homo sapiens'**
  String get modernHuman;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'pl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'pl': return AppLocalizationsPl();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
