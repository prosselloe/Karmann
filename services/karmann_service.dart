import 'dart:convert';
import 'dart:developer' as developer;
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http; 
import 'package:karmann/models/karmann_model.dart';

class KarmannService {
  static final KarmannService _instance = KarmannService._internal();
  factory KarmannService() => _instance;
  KarmannService._internal();

  List<KarmannModel>? _models;
  // Base URL for the raw JSON files on GitHub
  final String _githubBaseUrl =
      'https://raw.githubusercontent.com/prosselloe/Karmann/main/assets/data/';

  Future<List<KarmannModel>> getModels() async {
    // If models are already loaded, return them
    if (_models != null && _models!.isNotEmpty) {
      return _models!;
    }
    // Otherwise, load them
    await _loadModels();
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

  // Primary method to load models, tries GitHub first
  Future<void> _loadModels() async {
    try {
      developer.log('Attempting to load models from GitHub...', name: 'KarmannService');
      List<dynamic> allModelsJson = [];
      // Loop to fetch all 13 JSON files from GitHub
      for (int i = 1; i <= 13; i++) {
        final response = await http.get(Uri.parse('$_githubBaseUrl/db_$i.json'));
        if (response.statusCode == 200) {
          // The response body is already decoded as UTF-8 by the http package
          final jsonList = json.decode(utf8.decode(response.bodyBytes)) as List;
          allModelsJson.addAll(jsonList);
        } else {
          // If any file fails to load, throw an exception to trigger the fallback
          throw Exception('Failed to load db_$i.json from GitHub. Status code: ${response.statusCode}');
        }
      }
      _models = allModelsJson
          .map((json) => KarmannModel.fromJson(json))
          .toList();
      developer.log('Successfully loaded ${_models?.length} models from GitHub.', name: 'KarmannService');
    } catch (e, s) {
      // If loading from GitHub fails for any reason (network error, file not found, etc.)
      // log the error and fall back to loading from local assets.
      developer.log(
        'Failed to load models from GitHub. Falling back to local assets.',
        name: 'KarmannService',
        error: e,
        stackTrace: s,
      );
      await _loadModelsFromAssets();
    }
  }

  // Fallback method to load models from local assets
  Future<void> _loadModelsFromAssets() async {
    try {
      developer.log('Loading models from local assets...', name: 'KarmannService');
      List<dynamic> allModelsJson = [];

      for (int i = 1; i <= 13; i++) {
        final jsonString = await rootBundle.loadString(
          'assets/data/db_$i.json',
        );
        final jsonList = json.decode(jsonString) as List;
        allModelsJson.addAll(jsonList);
      }

      _models = allModelsJson
          .map((json) => KarmannModel.fromJson(json))
          .toList();
      developer.log('Successfully loaded ${_models?.length} models from local assets.', name: 'KarmannService');
    } catch (e, s) {
      // If loading from assets also fails, log the error and set models to an empty list.
      developer.log(
        'FATAL: Error loading models from local assets as well.',
        name: 'KarmannService',
        error: e,
        stackTrace: s,
      );
      _models = [];
    }
  }
}