import 'package:flutter/material.dart';
import 'package:karmann/models/karmann_model.dart';
import 'package:karmann/services/karmann_service.dart';

enum SortType { none, byName, byYear, byUnits }

class ModelProvider with ChangeNotifier {
  final KarmannService _karmannService = KarmannService();
  List<KarmannModel> _models = [];
  List<KarmannModel> _filteredModels = [];
  bool _isLoading = false;
  SortType _sortType = SortType.none;
  String? _selectedPlant;

  List<KarmannModel> get models => _filteredModels;
  bool get isLoading => _isLoading;
  SortType get sortType => _sortType;
  String? get selectedPlant => _selectedPlant;

  ModelProvider() {
    fetchModels();
  }

  Future<void> fetchModels() async {
    _isLoading = true;
    notifyListeners();

    _models = await _karmannService.getModels();
    _filteredModels = List.from(_models);
    // Ensure default sort by ID is applied on initial load
    sort(SortType.none, context: null, notify: false);

    _isLoading = false;
    notifyListeners();
  }

  List<String> getAvailablePlants(BuildContext context) {
    final plants = _models
        .map((model) => model.getManufacturingPlant(context))
        .whereType<String>() // Filters out nulls and ensures a List<String>
        .toSet()
        .toList();
    plants.sort();
    return plants;
  }

  void filterByPlant(String? plant, BuildContext context) {
    _selectedPlant = plant;
    search('', context); // Clear previous search and apply plant filter
  }

  List<KarmannModel> getModelsByIds(List<int> ids) {
    return _models.where((model) => ids.contains(model.id)).toList();
  }

  int? _getStartYear(String productionYears) {
    final regExp = RegExp(r'\d{4}');
    final match = regExp.firstMatch(productionYears);
    if (match != null) {
      return int.tryParse(match.group(0)!);
    }
    return null;
  }

  void search(String query, BuildContext context) {
    List<KarmannModel> tempModels = List.from(_models);

    // Filter by plant first
    if (_selectedPlant != null && _selectedPlant!.isNotEmpty) {
      tempModels = tempModels.where((model) {
        final plantName = model.getManufacturingPlant(context);
        return plantName != null && plantName == _selectedPlant;
      }).toList();
    }

    // Then, filter by search query
    if (query.isNotEmpty) {
      final lowerCaseQuery = query.toLowerCase();
      final searchYear = int.tryParse(query);

      tempModels = tempModels.where((model) {
        final modelName = model.getName(context).toLowerCase();
        if (modelName.contains(lowerCaseQuery)) {
          return true;
        }

        if (searchYear != null) {
          final yearsString = model.productionYears;
          final years = yearsString.split(RegExp(r'–|-'));

          final startYearStr = years.isNotEmpty ? years[0].trim() : '0';
          final startYear = int.tryParse(startYearStr);

          if (startYear != null) {
            if (years.length == 2) {
              final endYearStr = years[1].trim().toLowerCase();
              int? endYear;

              if (endYearStr == 'present') {
                endYear = DateTime.now().year;
              } else {
                endYear = int.tryParse(endYearStr);
              }

              if (endYear != null) {
                return searchYear >= startYear && searchYear <= endYear;
              }
            } else if (years.length == 1) {
              return searchYear == startYear;
            }
          }
        }

        return model.productionYears.contains(query);
      }).toList();
    }

    _filteredModels = tempModels;
    sort(_sortType, context: context, notify: false);
    notifyListeners();
  }

  void sort(SortType type, {bool notify = true, BuildContext? context}) {
    _sortType = type;
    switch (type) {
      case SortType.byName:
        if (context == null) return;
        _filteredModels.sort(
          (a, b) => a.getName(context).compareTo(b.getName(context)),
        );
        break;
      case SortType.byYear:
        _filteredModels.sort((a, b) {
          final yearA = _getStartYear(a.productionYears) ?? 0;
          final yearB = _getStartYear(b.productionYears) ?? 0;
          return yearA.compareTo(yearB);
        });
        break;
      case SortType.byUnits:
        _filteredModels.sort((a, b) {
          return b.unitsProduced.compareTo(a.unitsProduced);
        });
        break;
      case SortType.none:
        _filteredModels.sort((a, b) => a.id.compareTo(b.id));
        break;
    }
    if (notify) {
      notifyListeners();
    }
  }
}
