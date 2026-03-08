import 'dart:convert';
import 'dart:developer' as developer;
import 'package:flutter/services.dart';
import 'package:karmann/models/karmann_model.dart';

class KarmannService {
  static final KarmannService _instance = KarmannService._internal();
  factory KarmannService() => _instance;
  KarmannService._internal();

  List<KarmannModel>? _models;

  Future<List<KarmannModel>> getModels() async {
    if (_models == null) {
      await _loadModels();
    }
    return _models ?? [];
  }

  Future<KarmannModel?> getModelById(int id) async {
    final models = await getModels();
    try {
      return models.firstWhere((model) => model.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<void> _loadModels() async {
    try {
      List<dynamic> allModelsJson = [];

      for (int i = 1; i <= 12; i++) {
        final jsonString = await rootBundle.loadString(
          'assets/data/db_$i.json',
        );
        final jsonList = json.decode(jsonString) as List;
        allModelsJson.addAll(jsonList);
      }

      _models = allModelsJson
          .map((json) => KarmannModel.fromJson(json))
          .toList();
    } catch (e, s) {
      // Handle errors, e.g., file not found, JSON parsing error
      developer.log(
        'Error loading models',
        name: 'KarmannService',
        error: e,
        stackTrace: s,
      );
      _models = [];
    }
  }
}
