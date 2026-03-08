// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Karmann Passion';

  @override
  String get searchHint => 'Search by name or year...';

  @override
  String get filterAll => 'All';

  @override
  String get filterCabriolet => 'Cabriolets';

  @override
  String get dataSheetTitle => 'Key Data';

  @override
  String get designerLabel => 'Designer';

  @override
  String get engineLabel => 'Engine';

  @override
  String get topSpeedLabel => 'Top Speed';

  @override
  String get versionsTitle => 'Versions & Changes';

  @override
  String get noResults => 'No results found';

  @override
  String get relatedModelsTitle => 'Related Models';

  @override
  String get mainChangesLabel => 'Main Changes';

  @override
  String get productionDataLabel => 'Production Data';

  @override
  String get productionDetailsLabel => 'Production Details';

  @override
  String get sortByName => 'Sort by name';

  @override
  String get sortByYear => 'Sort by year';

  @override
  String get sortDefault => 'No sort';
}
