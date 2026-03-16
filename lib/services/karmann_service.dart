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
    List<KarmannModel> loadedModels = [];

    for (int i = 1; i <= 13; i++) {
      try {
        final jsonString = await rootBundle.loadString(
          'assets/data/db_$i.json',
        );
        final jsonList = json.decode(jsonString) as List;
        for (var jsonItem in jsonList) {
          try {
            loadedModels.add(KarmannModel.fromJson(jsonItem));
          } catch (e, s) {
            developer.log(
              'Error parsing model from db_$i.json',
              name: 'KarmannService',
              error: e,
              stackTrace: s,
            );
          }
        }
      } catch (e, s) {
        developer.log(
          'Error loading or parsing db_$i.json',
          name: 'KarmannService',
          error: e,
          stackTrace: s,
        );
      }
    }

    _models = loadedModels;
  }
}
