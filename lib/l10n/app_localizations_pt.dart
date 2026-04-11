// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Modelos Karmann';

  @override
  String get searchHint => 'Procurar modelos...';

  @override
  String get noResults => 'Nenhum resultado encontrado';

  @override
  String get sortByName => 'Ordenar por nome';

  @override
  String get sortByYear => 'Ordenar por ano';

  @override
  String get sortByUnits => 'Ordenar por unidades';

  @override
  String get sortDefault => 'Padrão';

  @override
  String get dataSheetTitle => 'Ficha de dados';

  @override
  String get designerLabel => 'Designer';

  @override
  String get engineLabel => 'Motor';

  @override
  String get topSpeedLabel => 'Velocidade máxima';

  @override
  String get unitsProducedLabel => 'Unidades produzidas';

  @override
  String get relatedModelsTitle => 'Modelos relacionados';

  @override
  String get versionsAndVariantsTitle => 'Versões e Variantes';

  @override
  String get manufacturingPlantLabel => 'Fábrica';

  @override
  String get filterByPlant => 'Filtrar por fábrica';

  @override
  String get allPlants => 'Todas as fábricas';

  @override
  String get filterActive => 'Filtro ativo';
}
