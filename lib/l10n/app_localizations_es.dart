// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Modelos Karmann';

  @override
  String get searchHint => 'Buscar modelos...';

  @override
  String get noResults => 'No se han encontrado resultsados';

  @override
  String get sortByName => 'Ordenar por nombre';

  @override
  String get sortByYear => 'Ordenar por año';

  @override
  String get sortByUnits => 'Ordenar por unidades';

  @override
  String get sortDefault => 'Por defecto';

  @override
  String get dataSheetTitle => 'Ficha técnica';

  @override
  String get designerLabel => 'Diseñador';

  @override
  String get engineLabel => 'Motor';

  @override
  String get topSpeedLabel => 'Velocidad máxima';

  @override
  String get unitsProducedLabel => 'Unidades producidas';

  @override
  String get relatedModelsTitle => 'Modelos relacionados';

  @override
  String get versionsAndVariantsTitle => 'Versiones y Variantes';

  @override
  String get manufacturingPlantLabel => 'Planta de fabricación';

  @override
  String get filterByPlant => 'Filtrar por planta';

  @override
  String get allPlants => 'Todas las plantas';

  @override
  String get filterActive => 'Filtro activo';
}
