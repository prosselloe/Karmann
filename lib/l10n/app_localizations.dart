import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ca.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';

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
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ca'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it')
  ];

  /// No description provided for @appTitle.
  ///
  /// In ca, this message translates to:
  /// **'Karmann Models'**
  String get appTitle;

  /// No description provided for @searchHint.
  ///
  /// In ca, this message translates to:
  /// **'Cercar per nom o any...'**
  String get searchHint;

  /// No description provided for @filterAll.
  ///
  /// In ca, this message translates to:
  /// **'Tots'**
  String get filterAll;

  /// No description provided for @filterCabriolet.
  ///
  /// In ca, this message translates to:
  /// **'Cabriolets'**
  String get filterCabriolet;

  /// No description provided for @dataSheetTitle.
  ///
  /// In ca, this message translates to:
  /// **'Dades Clau'**
  String get dataSheetTitle;

  /// No description provided for @designerLabel.
  ///
  /// In ca, this message translates to:
  /// **'Dissenyador'**
  String get designerLabel;

  /// No description provided for @engineLabel.
  ///
  /// In ca, this message translates to:
  /// **'Motor'**
  String get engineLabel;

  /// No description provided for @topSpeedLabel.
  ///
  /// In ca, this message translates to:
  /// **'Velocitat Màxima'**
  String get topSpeedLabel;

  /// No description provided for @versionsTitle.
  ///
  /// In ca, this message translates to:
  /// **'Versions i Canvis'**
  String get versionsTitle;

  /// No description provided for @noResults.
  ///
  /// In ca, this message translates to:
  /// **'No s\'han trobat resultats'**
  String get noResults;

  /// No description provided for @relatedModelsTitle.
  ///
  /// In ca, this message translates to:
  /// **'Models Relacionats'**
  String get relatedModelsTitle;

  /// No description provided for @mainChangesLabel.
  ///
  /// In ca, this message translates to:
  /// **'Canvis Principals'**
  String get mainChangesLabel;

  /// No description provided for @productionDataLabel.
  ///
  /// In ca, this message translates to:
  /// **'Dades de Producció'**
  String get productionDataLabel;

  /// No description provided for @productionDetailsLabel.
  ///
  /// In ca, this message translates to:
  /// **'Detalls de Producció'**
  String get productionDetailsLabel;

  /// No description provided for @sortByName.
  ///
  /// In ca, this message translates to:
  /// **'Ordena per nom'**
  String get sortByName;

  /// No description provided for @sortByYear.
  ///
  /// In ca, this message translates to:
  /// **'Ordena per any'**
  String get sortByYear;

  /// No description provided for @sortDefault.
  ///
  /// In ca, this message translates to:
  /// **'Sense ordenar'**
  String get sortDefault;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'ca',
        'de',
        'en',
        'es',
        'fr',
        'it'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ca':
      return AppLocalizationsCa();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
