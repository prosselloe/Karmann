import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:karmann/providers/model_provider.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class PlantMap extends StatefulWidget {
  const PlantMap({super.key});

  @override
  State<PlantMap> createState() => _PlantMapState();
}

class _PlantMapState extends State<PlantMap> {
  Future<List<dynamic>>? _plants;
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _plants = _loadPlants();
  }

  Future<List<dynamic>> _loadPlants() async {
    final String response = await rootBundle.loadString('assets/data/plants.json');
    final data = await json.decode(response);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _plants,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Error loading plants'));
        }

        final plants = snapshot.data!;
        final modelProvider = Provider.of<ModelProvider>(context);

        // Center map on selected plant
        if (modelProvider.selectedPlant != null) {
          final selectedPlantData = plants.firstWhere(
            (p) => p['name'] == modelProvider.selectedPlant,
            orElse: () => null,
          );
          if (selectedPlantData != null) {
            final coords = LatLng(
              selectedPlantData['coordinates']['latitude'],
              selectedPlantData['coordinates']['longitude'],
            );
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                _mapController.move(coords, 10.0);
              }
            });
          }
        }

        return FlutterMap(
          mapController: _mapController,
          options: const MapOptions(
            initialCenter: LatLng(51.509865, -0.118092),
            initialZoom: 4.0,
          ),
          children: [
            TileLayer(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: const ['a', 'b', 'c'],
              userAgentPackageName: 'dev.prosselloe.karmann',
            ),
            MarkerLayer(
              markers: plants.map((plant) {
                final isSelected = modelProvider.selectedPlant == plant['name'];
                return Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(plant['coordinates']['latitude'], plant['coordinates']['longitude']),
                  child: GestureDetector(
                    onTap: () {
                      modelProvider.filterByPlant(plant['name'], context);
                    },
                    child: Tooltip(
                      message: plant['name'],
                      child: Icon(
                        Icons.location_on,
                        color: isSelected ? Colors.cyan : Colors.red,
                        size: 40.0,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
