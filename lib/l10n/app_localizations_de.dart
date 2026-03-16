// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Karmann Modelle';

  @override
  String get searchHint => 'Modelle suchen...';

  @override
  String get noResults => 'Keine Ergebnisse gefunden';

  @override
  String get sortByName => 'Nach Name sortieren';

  @override
  String get sortByYear => 'Nach Jahr sortieren';

  @override
  String get sortByUnits => 'Nach Einheiten sortieren';

  @override
  String get sortDefault => 'Standard';

  @override
  String get dataSheetTitle => 'Datenblatt';

  @override
  String get designerLabel => 'Designer';

  @override
  String get engineLabel => 'Motor';

  @override
  String get topSpeedLabel => 'Höchstgeschwindigkeit';

  @override
  String get unitsProducedLabel => 'Produzierte Einheiten';

  @override
  String get relatedModelsTitle => 'Verwandte Modelle';

  @override
  String get versionsAndVariantsTitle => 'Versionen und Varianten';

  @override
  String get manufacturingPlantLabel => 'Produktionsstätte';

  @override
  String get filterByPlant => 'Nach Werk filtern';

  @override
  String get allPlants => 'Alle Werke';

  @override
  String get filterActive => 'Filter aktiv';
}
