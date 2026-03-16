// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Karmann Models';

  @override
  String get searchHint => 'Search models...';

  @override
  String get noResults => 'No results found';

  @override
  String get sortByName => 'Sort by name';

  @override
  String get sortByYear => 'Sort by year';

  @override
  String get sortByUnits => 'Sort by units';

  @override
  String get sortDefault => 'Default';

  @override
  String get dataSheetTitle => 'Data Sheet';

  @override
  String get designerLabel => 'Designer';

  @override
  String get engineLabel => 'Engine';

  @override
  String get topSpeedLabel => 'Top speed';

  @override
  String get unitsProducedLabel => 'Units produced';

  @override
  String get relatedModelsTitle => 'Related Models';

  @override
  String get versionsAndVariantsTitle => 'Versions and Variants';

  @override
  String get manufacturingPlantLabel => 'Manufacturing Plant';

  @override
  String get filterByPlant => 'Filter by plant';

  @override
  String get allPlants => 'All plants';

  @override
  String get filterActive => 'Filter active';
}
