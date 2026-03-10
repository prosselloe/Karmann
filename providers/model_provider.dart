import 'package:flutter/material.dart';
import 'package:karmann/models/karmann_model.dart';
import 'package:karmann/services/karmann_service.dart';

enum SortType { none, byName, byYear }

class ModelProvider with ChangeNotifier {
  final KarmannService _karmannService = KarmannService();
  List<KarmannModel> _models = [];
  List<KarmannModel> _filteredModels = [];
  bool _isLoading = false;
  SortType _sortType = SortType.none;

  List<KarmannModel> get models => _filteredModels;
  bool get isLoading => _isLoading;
  SortType get sortType => _sortType;

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
    if (query.isEmpty) {
      _filteredModels = List.from(_models);
    } else {
      final lowerCaseQuery = query.toLowerCase();
      final searchYear = int.tryParse(query);

      _filteredModels = _models.where((model) {
        // Search by name (case-insensitive)
        final modelName = model.getName(context).toLowerCase();
        if (modelName.contains(lowerCaseQuery)) {
          return true;
        }

        // Search by production year
        if (searchYear != null) {
          final yearsString = model.productionYears;
          final years = yearsString.split(RegExp(r'–|-'));

          final startYearStr = years.isNotEmpty ? years[0].trim() : '0';
          final startYear = int.tryParse(startYearStr);

          if (startYear != null) {
            // Case 1: Range (e.g., '1955-1974')
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
            }
            // Case 2: Single year (e.g., '1970')
            else if (years.length == 1) {
              return searchYear == startYear;
            }
          }
        }

        // Fallback search if the query isn't a perfect year number but might be in the string
        return model.productionYears.contains(query);
      }).toList();
    }
    // Re-apply current sort order to search results
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
      case SortType.none:
        _filteredModels.sort((a, b) => a.id.compareTo(b.id));
        break;
    }
    if (notify) {
      notifyListeners();
    }
  }
}
