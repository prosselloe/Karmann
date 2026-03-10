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
  String get searchHint => 'Rechercher par nom ou année...';

  @override
  String get filterAll => 'Tous';

  @override
  String get filterCabriolet => 'Cabriolets';

  @override
  String get dataSheetTitle => 'Données Clés';

  @override
  String get designerLabel => 'Designer';

  @override
  String get engineLabel => 'Moteur';

  @override
  String get topSpeedLabel => 'Vitesse Maximale';

  @override
  String get versionsTitle => 'Versions & Modifications';

  @override
  String get noResults => 'Aucun résultat trouvé';

  @override
  String get relatedModelsTitle => 'Modèles Connexes';

  @override
  String get mainChangesLabel => 'Changements Principaux';

  @override
  String get productionDataLabel => 'Données de Production';

  @override
  String get productionDetailsLabel => 'Détails de Production';

  @override
  String get sortByName => 'Trier par nom';

  @override
  String get sortByYear => 'Trier par année';

  @override
  String get sortDefault => 'Pas de tri';
}
