// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Modèles Karmann';

  @override
  String get searchHint => 'Rechercher des modèles...';

  @override
  String get noResults => 'Aucun résultat trouvé';

  @override
  String get sortByName => 'Trier par nom';

  @override
  String get sortByYear => 'Trier par année';

  @override
  String get sortByUnits => 'Trier par unités';

  @override
  String get sortDefault => 'Défaut';

  @override
  String get dataSheetTitle => 'Fiche technique';

  @override
  String get designerLabel => 'Designer';

  @override
  String get engineLabel => 'Moteur';

  @override
  String get topSpeedLabel => 'Vitesse maximale';

  @override
  String get unitsProducedLabel => 'Unités produites';

  @override
  String get relatedModelsTitle => 'Modèles associés';

  @override
  String get versionsAndVariantsTitle => 'Versions et Variantes';

  @override
  String get manufacturingPlantLabel => 'Usine de fabrication';

  @override
  String get filterByPlant => 'Filtrer par usine';

  @override
  String get allPlants => 'Toutes les usines';

  @override
  String get filterActive => 'Filtre actif';
}
