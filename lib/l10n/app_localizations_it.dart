// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Modelli Karmann';

  @override
  String get searchHint => 'Cerca modelli...';

  @override
  String get noResults => 'Nessun risultato trovato';

  @override
  String get sortByName => 'Ordina per nome';

  @override
  String get sortByYear => 'Ordina per anno';

  @override
  String get sortByUnits => 'Ordina per unità';

  @override
  String get sortDefault => 'Predefinito';

  @override
  String get dataSheetTitle => 'Scheda dati';

  @override
  String get designerLabel => 'Designer';

  @override
  String get engineLabel => 'Motore';

  @override
  String get topSpeedLabel => 'Velocità massima';

  @override
  String get unitsProducedLabel => 'Unità prodotte';

  @override
  String get relatedModelsTitle => 'Modelli correlati';

  @override
  String get versionsAndVariantsTitle => 'Versioni e Varianti';

  @override
  String get manufacturingPlantLabel => 'Impianto di produzione';

  @override
  String get filterByPlant => 'Filtra per impianto';

  @override
  String get allPlants => 'Tutti gli impianti';

  @override
  String get filterActive => 'Filtro attivo';
}
