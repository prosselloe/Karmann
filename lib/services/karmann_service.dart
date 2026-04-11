import 'dart:convert';
import 'dart:developer' as developer;
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:karmann/models/karmann_model.dart';
import 'package:karmann/models/plant.dart';

class KarmannService {
  static final KarmannService _instance = KarmannService._internal();
  factory KarmannService() => _instance;
  KarmannService._internal();

  List<KarmannModel>? _models;
  List<Plant>? _plants;

  Future<List<KarmannModel>> getModels() async {
    // Si els models ja estan carregats, els retornem directament.
    // Per forçar una recàrrega, s'hauria de posar _models a null.
    if (_models == null) {
      await _loadModels();
    }
    return _models ?? [];
  }

  Future<List<Plant>> getPlants() async {
    if (_plants == null) {
      await _loadPlants();
    }
    return _plants ?? [];
  }

  Future<void> _loadPlants() async {
    const String baseUrl = 'https://raw.githubusercontent.com/prosselloe/Karmann/main/assets/data/';
    const String fileName = 'plants.json';
    final Uri remoteUrl = Uri.parse('$baseUrl$fileName');
    String jsonString;

    try {
      // 1. Intent de càrrega remota
      developer.log('Attempting to load remote data from: $remoteUrl', name: 'KarmannService');
      final response = await http.get(remoteUrl);

      if (response.statusCode == 200) {
        jsonString = response.body;
        developer.log('Successfully loaded remote data for $fileName.', name: 'KarmannService');
      } else {
        throw Exception('Failed to load remote data (status code: ${response.statusCode})');
      }
    } catch (e) {
      // 2. Fallback a càrrega local
      developer.log('Error loading remote data for $fileName: $e', name: 'KarmannService');
      developer.log('Falling back to local asset for $fileName.', name: 'KarmannService');
      try {
        jsonString = await rootBundle.loadString('assets/data/$fileName');
        developer.log('Successfully loaded local data for $fileName.', name: 'KarmannService');
      } catch (localError, s) {
        developer.log(
          'Failed to load local asset for $fileName: $localError',
          name: 'KarmannService',
          error: localError,
          stackTrace: s,
        );
        _plants = [];
        return;
      }
    }

    // 3. Anàlisi del JSON
    try {
      final jsonList = json.decode(jsonString) as List;
      _plants = jsonList.map((json) => Plant.fromJson(json)).toList();
    } catch (e, s) {
      developer.log(
        'Error loading or parsing plants.json',
        name: 'KarmannService',
        error: e,
        stackTrace: s,
      );
      _plants = [];
    }
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
    const String baseUrl = 'https://raw.githubusercontent.com/prosselloe/Karmann/main/assets/data/';

    for (int i = 1; i <= 13; i++) {
      String jsonString;
      final String fileName = 'db_$i.json';
      final Uri remoteUrl = Uri.parse('$baseUrl$fileName');

      try {
        // 1. Intent de càrrega remota
        developer.log('Attempting to load remote data from: $remoteUrl', name: 'KarmannService');
        final response = await http.get(remoteUrl);

        if (response.statusCode == 200) {
          jsonString = response.body;
          developer.log('Successfully loaded remote data for $fileName.', name: 'KarmannService');
        } else {
          throw Exception('Failed to load remote data (status code: ${response.statusCode})');
        }
      } catch (e) {
        // 2. Fallback a càrrega local
        developer.log('Error loading remote data for $fileName: $e', name: 'KarmannService');
        developer.log('Falling back to local asset for $fileName.', name: 'KarmannService');
        try {
          jsonString = await rootBundle.loadString('assets/data/$fileName');
          developer.log('Successfully loaded local data for $fileName.', name: 'KarmannService');
        } catch (localError, s) {
          developer.log(
            'Failed to load local asset for $fileName: $localError',
            name: 'KarmannService',
            error: localError,
            stackTrace: s,
          );
          continue; // Si ni el remot ni el local funcionen, passem al següent fitxer
        }
      }

      // 3. Anàlisi del JSON
      try {
        final jsonList = json.decode(jsonString) as List;
        for (var jsonItem in jsonList) {
          try {
            loadedModels.add(KarmannModel.fromJson(jsonItem));
          } catch (e, s) {
            developer.log(
              'Error parsing model from $fileName',
              name: 'KarmannService',
              error: e,
              stackTrace: s,
            );
          }
        }
      } catch (e, s) {
         developer.log(
          'Error parsing the entire JSON structure from $fileName',
          name: 'KarmannService',
          error: e,
          stackTrace: s,
        );
      }
    }

    _models = loadedModels;
  }
}
