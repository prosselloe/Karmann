import 'package:flutter/material.dart';

class Version {
  final Map<String, String> versionName;
  final String imageUrl;
  final String? productionYears;
  final Map<String, String> changes;

  Version({
    required this.versionName,
    required this.imageUrl,
    this.productionYears,
    required this.changes,
  });

  factory Version.fromJson(Map<String, dynamic> json) {
    return Version(
      versionName: Map<String, String>.from(json['versionName']),
      imageUrl: json['imageUrl'] as String,
      productionYears: json['productionYears'] as String?,
      changes: Map<String, String>.from(json['changes']),
    );
  }

  String _getLocalizedString(Map<String, String> map, BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    return map[locale] ?? map['ca'] ?? map.values.first;
  }

  String getVersionName(BuildContext context) => _getLocalizedString(versionName, context);
  String getChanges(BuildContext context) => _getLocalizedString(changes, context);
}

class KarmannModel {
  final int id;
  final Map<String, String> name;
  final String productionYears;
  final String imageUrl;
  final bool isCabriolet;
  final Map<String, String> description;
  final String? designer;
  final Map<String, String>? engine;
  final Map<String, String>? topSpeed;
  final int unitsProduced;
  final List<int> relatedModels;
  final List<Version> versions;
  final String? manufacturingPlant;

  KarmannModel({
    required this.id,
    required this.name,
    required this.productionYears,
    required this.imageUrl,
    required this.isCabriolet,
    required this.description,
    this.designer,
    this.engine,
    this.topSpeed,
    required this.unitsProduced,
    required this.relatedModels,
    this.versions = const [],
    this.manufacturingPlant,
  });

  factory KarmannModel.fromJson(Map<String, dynamic> json) {
    var versionsList = json['versions'] as List<dynamic>? ?? [];
    List<Version> versions = versionsList.map((v) => Version.fromJson(v)).toList();

    return KarmannModel(
      id: json['id'] as int,
      name: Map<String, String>.from(json['name']),
      productionYears: json['productionYears'] as String,
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
      unitsProduced: json['unitsProduced'] as int,
      relatedModels: (json['relatedModels'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      versions: versions,
      manufacturingPlant: json['manufacturingPlant'] as String?,
    );
  }

  String _getLocalizedString(Map<String, String> map, BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    return map[locale] ?? map['ca'] ?? map.values.first;
  }

  String? _getLocalizedOptionalString(
      Map<String, String>? map, BuildContext context) {
    if (map == null) return null;
    final locale = Localizations.localeOf(context).languageCode;
    return map[locale] ?? map['ca'] ?? map.values.first;
  }

  String getName(BuildContext context) => _getLocalizedString(name, context);
  String getDescription(BuildContext context) =>
      _getLocalizedString(description, context);
  String? getEngine(BuildContext context) =>
      _getLocalizedOptionalString(engine, context);
  String? getTopSpeed(BuildContext context) =>
      _getLocalizedOptionalString(topSpeed, context);
  String? getManufacturingPlant(BuildContext context) => manufacturingPlant;
}
