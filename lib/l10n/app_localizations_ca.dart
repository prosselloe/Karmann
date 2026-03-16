// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Catalan Valencian (`ca`).
class AppLocalizationsCa extends AppLocalizations {
  AppLocalizationsCa([String locale = 'ca']) : super(locale);

  @override
  String get appTitle => 'Models Karmann';

  @override
  String get searchHint => 'Cerca models...';

  @override
  String get noResults => 'No s\'han trobat resultats';

  @override
  String get sortByName => 'Ordenar per nom';

  @override
  String get sortByYear => 'Ordenar per any';

  @override
  String get sortByUnits => 'Ordenar per unitats';

  @override
  String get sortDefault => 'Per defecte';

  @override
  String get dataSheetTitle => 'Fitxa tècnica';

  @override
  String get designerLabel => 'Dissenyador';

  @override
  String get engineLabel => 'Motor';

  @override
  String get topSpeedLabel => 'Velocitat màxima';

  @override
  String get unitsProducedLabel => 'Unitats produïdes';

  @override
  String get relatedModelsTitle => 'Models relacionats';

  @override
  String get versionsAndVariantsTitle => 'Versions i Variants';

  @override
  String get manufacturingPlantLabel => 'Planta de fabricació';

  @override
  String get filterByPlant => 'Filtrar per planta';

  @override
  String get allPlants => 'Totes les plantes';

  @override
  String get filterActive => 'Filtre actiu';
}
