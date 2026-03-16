import 'package:flutter/material.dart';

// Funció auxiliar per a obtenir la cadena de text localitzada de manera robusta
String _getLocalizedString(Map<String, String> map, String locale) {
  return map[locale] ?? map['ca'] ?? map.values.first;
}

// Versió de la funció per a camps opcionals
String? _getLocalizedOptionalString(Map<String, String>? map, String locale) {
  if (map == null) return null;
  return map[locale] ?? map['ca'] ?? map.values.first;
}

class KarmannModel {
  final int id;
  final Map<String, String> name;
  final String productionYears;
  final int unitsProduced;
  final String imageUrl;
  final bool isCabriolet;
  final Map<String, String> description;
  final String? designer;
  final Map<String, String>? engine;
  final Map<String, String>? topSpeed;
  final List<ModelVersion> versions;
  final List<int> relatedModels;

  KarmannModel({
    required this.id,
    required this.name,
    required this.productionYears,
    required this.unitsProduced,
    required this.imageUrl,
    required this.isCabriolet,
    required this.description,
    this.designer,
    this.engine,
    this.topSpeed,
    required this.versions,
    required this.relatedModels,
  });

  factory KarmannModel.fromJson(Map<String, dynamic> json) {
    return KarmannModel(
      id: json['id'] as int,
      name: Map<String, String>.from(json['name']),
      productionYears: json['productionYears'] as String,
      unitsProduced: json['unitsProduced'] as int,
      imageUrl: json['imageUrl'] as String,
      isCabriolet: json['isCabriolet'] as bool,
      description: Map<String, String>.from(json['description']),
      designer: json['designer'] as String?,
      engine: json['engine'] != null
          ? Map<String, String>.from(json['engine'])
          : null,
      topSpeed: json['topSpeed'] != null
          ? Map<String, String>.from(json['topSpeed'])
          : null,
      versions: (json['versions'] as List<dynamic>)
          .map((v) => ModelVersion.fromJson(v as Map<String, dynamic>))
          .toList(),
      relatedModels: (json['relatedModels'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
    );
  }

  String getName(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    return _getLocalizedString(name, locale);
  }

  String getDescription(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    return _getLocalizedString(description, locale);
  }

  String? getEngine(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    return _getLocalizedOptionalString(engine, locale);
  }

  String? getTopSpeed(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    return _getLocalizedOptionalString(topSpeed, locale);
  }
}

class ModelVersion {
  final Map<String, String> versionName;
  final String productionYears;
  final Map<String, String> changes;
  final Map<String, String>? annualProduction;
  final Map<String, String>? productionDetails;

  ModelVersion({
    required this.versionName,
    required this.productionYears,
    required this.changes,
    this.annualProduction,
    this.productionDetails,
  });

  factory ModelVersion.fromJson(Map<String, dynamic> json) {
    return ModelVersion(
      versionName: Map<String, String>.from(json['versionName']),
      productionYears: json['productionYears'] as String,
      changes: Map<String, String>.from(json['changes']),
      annualProduction: json['annualProduction'] != null
          ? Map<String, String>.from(json['annualProduction'])
          : null,
      productionDetails: json['productionDetails'] != null
          ? Map<String, String>.from(json['productionDetails'])
          : null,
    );
  }

  String getVersionName(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    return _getLocalizedString(versionName, locale);
  }

  String getChanges(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    return _getLocalizedString(changes, locale);
  }

  String? getAnnualProduction(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    return _getLocalizedOptionalString(annualProduction, locale);
  }

  String? getProductionDetails(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    return _getLocalizedOptionalString(productionDetails, locale);
  }
}
